List<UserRatingSuccessDto> listUserRatingSuccessDto(List<dynamic> data) =>
    List<UserRatingSuccessDto>.from(
        data.map((e) => UserRatingSuccessDto.fromJson(e)));

class UserRatingSuccessDto {
  final String email;
  final int rating;
  final String nameVersion;
  final String reviewOptions;
  final DateTime createdAt;

  UserRatingSuccessDto({
    required this.email,
    required this.rating,
    required this.nameVersion,
    required this.reviewOptions,
    required this.createdAt,
  });

  factory UserRatingSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserRatingSuccessDto(
        email: json['email'],
        rating: json['rating'],
        nameVersion: json['nameVersion'],
        reviewOptions: json['reviewOptions'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}
