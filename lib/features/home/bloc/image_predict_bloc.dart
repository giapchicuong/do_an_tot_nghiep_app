import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:remove_bg/remove_bg.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../utils/constants/models.dart';
import '../../../utils/formatters/formatter.dart';
import 'image_predict_event.dart';
import 'image_predict_state.dart';

class ImagePredictBloc extends Bloc<ImagePredictEvent, ImagePredictState> {
  late Interpreter _interpreter;

  ImagePredictBloc() : super(ImagePredictInitial()) {
    on<LoadModelEvent>(_onLoadModel);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<PerformPredictionEvent>(_onPerformPrediction);
  }

  Future<void> _onLoadModel(
      LoadModelEvent event, Emitter<ImagePredictState> emit) async {
    try {
      _interpreter = await Interpreter.fromAsset(AppModel.urlModel);
    } catch (e) {
      print("Error Load Model ${e}");
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
      add(PerformPredictionEvent(File(pickedFile.path)));
    } else {
      emit(ImagePredictInitial());
    }
  }

  Future<void> _onPerformPrediction(
      PerformPredictionEvent event, Emitter<ImagePredictState> emit) async {
    emit(ImagePredictLoading());
    try {
      final removeBgResponse = await Remove().bg(
        event.imageFile,
        privateKey: "VAcHahQfpQab565WMp7v8RQ4",
        onUploadProgressCallback: (progressValue) {
          emit(ImagePredictLoading());
        },
      );
      Uint8List imageData = removeBgResponse!;

      img.Image? image = img.decodeImage(imageData);
      if (image == null) throw Exception("Invalid image");

      img.Image resizedImage = img.copyResize(image, width: 224, height: 224);
      var input = _processImage(resizedImage);
      var output = List.generate(
          1, (index) => List.filled(AppModel.classLabels.length, 0.0));

      _interpreter.run(input, output);
      _parseOutput(
        output,
        event.imageFile,
        imageData,
        emit,
      );
    } catch (e) {
      print("Error Prediction Model ${e}");
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

  void _parseOutput(List<List<double>> output, File image,
      Uint8List? imageRemove, Emitter<ImagePredictState> emit) {
    int predictedClass =
        output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));
    String fruitType = AppModel.classLabels[predictedClass];
    print('Name Fruits: $fruitType');
    print('Name Custom Fruits: ${AppFormatter.formatLabelModel(fruitType)}');

    emit(
      ImagePredictSuccess(
          AppFormatter.formatLabelModel(fruitType), image, imageRemove),
    );
  }
}
