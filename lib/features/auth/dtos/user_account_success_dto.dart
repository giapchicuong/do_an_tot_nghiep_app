class UserAccountSuccessDto {
  final String email;
  final int userId;
  final int groupId;
  final String accessToken;
  final bool isVip;
  final Durations? durations;

  UserAccountSuccessDto({
    required this.email,
    required this.userId,
    required this.groupId,
    required this.accessToken,
    required this.isVip,
    required this.durations,
  });

  factory UserAccountSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserAccountSuccessDto(
          email: json['email'],
          userId: json['userId'],
          groupId: json['groupId'],
          accessToken: json['accessToken'],
          isVip: json['isVip'],
          durations: json['durations'] != null
              ? Durations.fromJson(json['durations'])
              : null);
}

class Durations {
  final int durationId;

  Durations({required this.durationId});

  factory Durations.fromJson(Map<String, dynamic> json) => Durations(
        durationId: json['durationId'],
      );
}
