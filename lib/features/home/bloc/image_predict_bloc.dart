import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/features/home/data/home_repository.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/upload_image_dto.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/upload_image_success_dto.dart';
import 'package:do_an_tot_nghiep/features/result_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../utils/constants/models.dart';
import '../../../utils/formatters/formatter.dart';
import 'image_predict_event.dart';
import 'image_predict_state.dart';

class ImagePredictBloc extends Bloc<ImagePredictEvent, ImagePredictState> {
  late Interpreter _interpreter;

  ImagePredictBloc(this.homeRepository) : super(ImagePredictInitial()) {
    on<LoadModelEvent>(_onLoadModel);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<PerformPredictionEvent>(_onPerformPrediction);
  }
  final HomeRepository homeRepository;

  Future<void> _onLoadModel(
      LoadModelEvent event, Emitter<ImagePredictState> emit) async {
    try {
      _interpreter = await Interpreter.fromAsset(AppModel.urlModel);
    } catch (e) {
      print("Error Load Model $e");
      emit(ImagePredictFailure("Failed to load model"));
    }
  }

  Future<void> _onPickImageFromGallery(
      PickImageFromGalleryEvent event, Emitter<ImagePredictState> emit) async {
    final picker = ImagePicker();
    emit(ImagePredictLoading());

    final pickedFile = await picker.pickImage(
        source: event.isCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      add(PerformPredictionEvent(
          imageFile: File(pickedFile.path),
          isVip: event.isVip,
          isAuth: event.isAuth));
    } else {
      emit(ImagePredictInitial());
    }
  }

  Future<void> _onPerformPrediction(
      PerformPredictionEvent event, Emitter<ImagePredictState> emit) async {
    emit(ImagePredictLoading());
    try {
      final mimeType = lookupMimeType(event.imageFile.path);
      MultipartFile dataImagePost = await MultipartFile.fromFile(
          event.imageFile.path,
          filename: event.imageFile.path.split('/').last,
          contentType: mimeType != null
              ? DioMediaType.parse(mimeType)
              : DioMediaType.parse("image/jpeg"));

      final result = await homeRepository.uploadImage(
          uploadImageDto: UploadImageDto(image: dataImagePost));

      if (result is Success<UploadImageSuccessDto>) {
        Uint8List imageData = base64Decode(result.data.image);
        img.Image? image = img.decodeImage(imageData);
        if (image == null) throw Exception("Invalid image");

        img.Image resizedImage = img.copyResize(image, width: 224, height: 224);
        // var input = _processImage(resizedImage);
        var input = preprocessImage(resizedImage, "tf", "channels_last");
        // var input = preprocessImage(resizedImage, "tf", "channels_last");

        var output = List.generate(
            1, (index) => List.filled(AppModel.classLabels.length, 0.0));

        print(input);

        _interpreter.run(input, output);
        _parseOutput(
          output,
          event.imageFile,
          imageData,
          result.data.imageName,
          event.isVip,
          event.isAuth,
          emit,
        );
      }
      if (result is Failure<UploadImageSuccessDto>) {
        emit(ImagePredictFailure("Remove Background failed ${result.message}"));
      }
    } catch (e) {
      print("Error Prediction Model $e");
      emit(ImagePredictFailure("Prediction failed"));
    }
  }

  // ban đầu
  // List<List<List<List<double>>>> _processImage(img.Image image) {
  //   return List.generate(
  //     1,
  //     (_) => List.generate(
  //       image.height,
  //       (j) => List.generate(
  //         image.width,
  //         (k) {
  //           var pixel = image.getPixel(k, j);
  //           num r1 = (pixel >> 16 & 0xFF);
  //           r1 = (r1 - 123.68);
  //           var r = (r1) / 255.0;
  //
  //           num g1 = (pixel >> 8 & 0xFF);
  //           g1 = (g1 - 116.779);
  //           var g = (g1) / 255.0;
  //
  //           num b1 = (pixel & 0xFF);
  //           b1 = (b1 - 103.939);
  //           var b = (b1) / 255.0;
  //
  //           return [b, g, r];
  //         },
  //       ),
  //     ),
  //   );
  // }

  List<List<List<List<double>>>> preprocessImage(
      img.Image image, String mode, String dataFormat) {
    // Chuẩn bị các tham số mean và std
    List<double> mean;
    List<double>? std;

    if (mode == "tf") {
      mean = [0.0, 0.0, 0.0];
      std = null;
    } else if (mode == "torch") {
      mean = [0.485, 0.456, 0.406];
      std = [0.229, 0.224, 0.225];
    } else {
      mean = [103.939, 116.779, 123.68];
      std = null;
    }

    return List.generate(
      1,
      (_) => List.generate(
        image.height,
        (j) => List.generate(
          image.width,
          (k) {
            var pixel = image.getPixel(k, j);
            double r = ((pixel >> 16) & 0xFF).toDouble();
            double g = ((pixel >> 8) & 0xFF).toDouble();
            double b = (pixel & 0xFF).toDouble();
            // Chuyển đổi RGB -> BGR nếu cần
            if (mode != "tf" && dataFormat == "channels_last") {
              var temp = r;
              r = b;
              b = temp;
            }

            // Chuẩn hóa giá trị pixel
            r = _normalizePixel(r, mean[0], std != null ? std[0] : null, mode);
            g = _normalizePixel(g, mean[1], std != null ? std[1] : null, mode);
            b = _normalizePixel(b, mean[2], std != null ? std[2] : null, mode);

            return [r, g, b];
          },
        ),
      ),
    );
  }

  double _normalizePixel(double pixel, double mean, double? std, String mode) {
    if (mode == "tf") {
      return (pixel / 127.5) - 1.0; // Scale -1 to 1
    } else if (mode == "torch") {
      pixel /= 255.0; // Scale 0 to 1
      return (pixel - mean) / (std ?? 1.0); // Normalize by mean and std
    } else {
      return pixel - mean; // Zero-center by mean pixel
    }
  }

  // List<List<List<List<double>>>> preprocessImage(
  //     img.Image image, String mode, String dataFormat) {
  //   List<double> mean;
  //   List<double>? std;
  //
  //   // Xác định mean và std theo chế độ
  //   if (mode == "tf") {
  //     mean = [0.0, 0.0, 0.0];
  //     std = null;
  //   } else if (mode == "torch") {
  //     mean = [0.485, 0.456, 0.406];
  //     std = [0.229, 0.224, 0.225];
  //   } else {
  //     // "caffe"
  //     mean = [103.939, 116.779, 123.68];
  //     std = null;
  //   }
  //
  //   // Xử lý ảnh đầu vào
  //   return List.generate(
  //     1,
  //     (_) => List.generate(
  //       image.height,
  //       (j) => List.generate(
  //         image.width,
  //         (k) {
  //           // Lấy giá trị RGB từ pixel
  //           var pixel = image.getPixel(k, j);
  //           double r = ((pixel >> 16) & 0xFF).toDouble();
  //           double g = ((pixel >> 8) & 0xFF).toDouble();
  //           double b = (pixel & 0xFF).toDouble();
  //
  //           // Chuyển đổi RGB -> BGR nếu mode là "caffe" và dataFormat là "channels_last"
  //           if (mode == "caffe" && dataFormat == "channels_last") {
  //             var temp = r;
  //             r = b;
  //             b = temp;
  //           }
  //
  //           // Chuẩn hóa từng kênh màu
  //           r = _normalizePixel(r, mean[0], std != null ? std[0] : null, mode);
  //           g = _normalizePixel(g, mean[1], std != null ? std[1] : null, mode);
  //           b = _normalizePixel(b, mean[2], std != null ? std[2] : null, mode);
  //
  //           return [r, g, b];
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // double _normalizePixel(double pixel, double mean, double? std, String mode) {
  //   if (mode == "tf") {
  //     return (pixel / 127.5) - 1.0; // Scale -1 to 1
  //   } else if (mode == "torch") {
  //     pixel /= 255.0; // Scale 0 to 1
  //     return (pixel - mean) / (std ?? 1.0); // Normalize by mean and std
  //   } else {
  //     // "caffe"
  //     return pixel - mean; // Zero-center by mean pixel
  //   }
  // }

  void _parseOutput(
      List<List<double>> output,
      File image,
      Uint8List? imageRemove,
      String imageUrl,
      bool isVip,
      bool isAuth,
      Emitter<ImagePredictState> emit) async {
    print(output);
    int predictedClass =
        output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

    print(predictedClass);

    String fruitType = AppModel.classLabels[predictedClass];
    print('Name Fruits: $fruitType');
    print('Name Custom Fruits: ${AppFormatter.formatLabelModel(fruitType)}');

    String percentValue = AppFormatter.formatLabelModelGetNumber(fruitType);
    String ratingName = AppFormatter.formatLabelModelGetName(fruitType);

    if (!isVip) {
      if (int.parse(AppFormatter.formatLabelModelGetNumber(fruitType)) >= 50) {
        percentValue = '100';
      } else {
        percentValue = '0';
      }
    }
    emit(
      ImagePredictSuccess('$ratingName - $percentValue%', image, imageRemove),
    );
    if (isAuth) {
      await homeRepository.postResultReview(
          ratingValue: percentValue,
          ratingName: ratingName,
          imageUrl: imageUrl);
    }
  }
}
