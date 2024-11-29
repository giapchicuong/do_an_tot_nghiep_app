class UserRatingSuccessDto {
  bool isRating;
  List<ListRating> listRating;

  UserRatingSuccessDto({
    required this.isRating,
    required this.listRating,
  });

  factory UserRatingSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserRatingSuccessDto(
        isRating: json["isRating"],
        listRating: List<ListRating>.from(
            json["listRating"].map((x) => ListRating.fromJson(x))),
      );
}

class ListRating {
  String email;
  int rating;
  String nameVersion;
  String reviewOptions;
  DateTime createdAt;

  ListRating({
    required this.email,
    required this.rating,
    required this.nameVersion,
    required this.reviewOptions,
    required this.createdAt,
  });

  factory ListRating.fromJson(Map<String, dynamic> json) => ListRating(
        email: json["email"],
        rating: json["rating"],
        nameVersion: json["nameVersion"],
        reviewOptions: json["reviewOptions"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
