import 'dart:io';

abstract class ImagePredictEvent {}

class LoadModelEvent extends ImagePredictEvent {}

class PickImageFromGalleryEvent extends ImagePredictEvent {
  final bool isCamera;

  PickImageFromGalleryEvent({required this.isCamera});
}

class PerformPredictionEvent extends ImagePredictEvent {
  final File imageFile;

  PerformPredictionEvent(this.imageFile);
}
