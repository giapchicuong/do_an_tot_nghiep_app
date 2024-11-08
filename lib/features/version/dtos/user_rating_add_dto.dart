class UserRatingAdDto {
  final int userId;
  final int versionId;
  final int rating;
  final List<ReviewOptions> reviewOptions;

  UserRatingAdDto({
    required this.userId,
    required this.versionId,
    required this.rating,
    required this.reviewOptions,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "versionId": versionId,
        "rating": rating,
        "reviewOptions": List<dynamic>.from(reviewOptions.map(
          (e) => e.toJSon(),
        ))
      };
}

class ReviewOptions {
  final int reviewOptionId;

  ReviewOptions({required this.reviewOptionId});

  Map<String, dynamic> toJSon() => {"reviewOptionId": reviewOptionId};
}
