class LoginSuccessDto {
  final String email;
  final int groupId;
  final String accessToken;
  final String refreshToken;

  LoginSuccessDto({
    required this.email,
    required this.groupId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) =>
      LoginSuccessDto(
        email: json['email'],
        groupId: json['groupId'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
