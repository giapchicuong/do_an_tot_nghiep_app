// class UploadImageSuccessDto {
//   final String imageName;
//   final String image;
//
//   UploadImageSuccessDto({required this.imageName, required this.image});
//
//   factory UploadImageSuccessDto.fromJson(Map<String, dynamic> json) =>
//       UploadImageSuccessDto(
//         imageName: json['imageName'],
//         image: json['image'],
//       );
// }

class UploadImageSuccessDto {
  final String nameFruits;
  final String valueRating;
  final String image;

  UploadImageSuccessDto(
      {required this.nameFruits,
      required this.image,
      required this.valueRating});

  factory UploadImageSuccessDto.fromJson(Map<String, dynamic> json) =>
      UploadImageSuccessDto(
        nameFruits: json['nameFruits'],
        valueRating: json['valueRating'],
        image: json['image_no_background'],
      );
}
