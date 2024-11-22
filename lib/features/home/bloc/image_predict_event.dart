import 'dart:io';

abstract class ImagePredictEvent {}

class LoadModelEvent extends ImagePredictEvent {}

class PickImageFromGalleryEvent extends ImagePredictEvent {
  final bool isCamera;
  final bool isVip;
  final bool isAuth;

  PickImageFromGalleryEvent({
    required this.isCamera,
    this.isVip = false,
    this.isAuth = false,
  });
}

class PerformPredictionEvent extends ImagePredictEvent {
  final File imageFile;
  final bool isVip;
  final bool isAuth;

  PerformPredictionEvent({required this.imageFile, this.isVip = false, this.isAuth = false});
}
