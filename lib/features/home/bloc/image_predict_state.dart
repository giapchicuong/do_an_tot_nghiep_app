import 'dart:io';

abstract class ImagePredictState {}

class ImagePredictInitial extends ImagePredictState {}

class ImagePredictLoading extends ImagePredictState {}

class ImagePredictSuccess extends ImagePredictState {
  final String result;
  final File image;

  ImagePredictSuccess(this.result, this.image);
}

class ImagePredictFailure extends ImagePredictState {
  final String message;

  ImagePredictFailure(this.message);
}
