class UploadImageSuccessDto {
  final String imageName;
  final String image;

  UploadImageSuccessDto({required this.imageName, required this.image});

  factory UploadImageSuccessDto.fromJson(Map<String, dynamic> json) =>
      UploadImageSuccessDto(
        imageName: json['imageName'],
        image: json['image'],
      );
}
