import 'dart:io';
import 'dart:typed_data';

abstract class ImagePredictState {}

class ImagePredictInitial extends ImagePredictState {}

class ImagePredictLoading extends ImagePredictState {}

class ImagePredictSuccess extends ImagePredictState {
  final String result;
  final File image;
  final Uint8List? imageRemove;

  ImagePredictSuccess(this.result, this.image, this.imageRemove);
}

class ImagePredictFailure extends ImagePredictState {
  final String message;

  ImagePredictFailure(this.message);
}
