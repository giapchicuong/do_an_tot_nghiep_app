abstract class ImagePredictState {}

class ImagePredictInitial extends ImagePredictState {}

class ImagePredictLoading extends ImagePredictState {}

class ImagePredictSuccess extends ImagePredictState {
  final String nameFruits;
  final String valueRating;
  final String image;

  ImagePredictSuccess(
      {required this.nameFruits,
      required this.valueRating,
      required this.image});
}

class ImagePredictFailure extends ImagePredictState {
  final String message;

  ImagePredictFailure(this.message);
}
