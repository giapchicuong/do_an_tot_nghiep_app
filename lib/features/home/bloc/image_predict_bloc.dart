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
        var input = _processImage(resizedImage);
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

  List<List<List<List<double>>>> _processImage(img.Image image) {
    return List.generate(
      1,
      (_) => List.generate(
        image.height,
        (j) => List.generate(
          image.width,
          (k) {
            var pixel = image.getPixel(k, j);
            var r = ((pixel >> 16) & 0xFF) / 255.0;
            var g = ((pixel >> 8) & 0xFF) / 255.0;
            var b = (pixel & 0xFF) / 255.0;
            return [r, g, b];
          },
        ),
      ),
    );
  }

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
