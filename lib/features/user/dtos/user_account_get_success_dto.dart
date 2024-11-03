class UserAccountGetSuccessDto {
  final String fullName;
  final String email;
  final int totalResultReview;
  final String statusName;
  final String timeInDayEnd;

  UserAccountGetSuccessDto(
      {required this.fullName,
      required this.email,
      required this.totalResultReview,
      required this.statusName,
      required this.timeInDayEnd});

  factory UserAccountGetSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserAccountGetSuccessDto(
        fullName: json['fullName'],
        email: json['email'],
        totalResultReview: json['totalResultReview'],
        statusName: json['statusName'],
        timeInDayEnd: json['timeInDayEnd'],
      );
}
