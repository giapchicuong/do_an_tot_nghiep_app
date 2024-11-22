class ResultReviewDto {
  final String ratingValue;
  final String ratingName;
  final String imageUrl;

  ResultReviewDto({
    required this.ratingValue,
    required this.ratingName,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'ratingValue': ratingValue,
        'ratingName': ratingName,
        'imageUrl': imageUrl,
      };
}
