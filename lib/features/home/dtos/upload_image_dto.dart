class UploadImageDto {
  final dynamic image;

  UploadImageDto({required this.image});

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}
