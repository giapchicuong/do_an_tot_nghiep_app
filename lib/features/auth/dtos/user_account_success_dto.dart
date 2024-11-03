class UserAccountSuccessDto {
  final String email;
  final int userId;
  final int groupId;
  final String accessToken;

  UserAccountSuccessDto({
    required this.email,
    required this.userId,
    required this.groupId,
    required this.accessToken,
  });

  factory UserAccountSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserAccountSuccessDto(
        email: json['email'],
        userId: json['userId'],
        groupId: json['groupId'],
        accessToken: json['accessToken'],
      );
}
