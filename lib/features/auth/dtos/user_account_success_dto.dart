class UserAccountSuccessDto {
  final String email;
  final int userId;
  final int groupId;
  final String accessToken;
  final bool isAdmin;
  final Durations? durations;

  UserAccountSuccessDto({
    required this.email,
    required this.userId,
    required this.groupId,
    required this.accessToken,
    required this.isAdmin,
    required this.durations,
  });

  factory UserAccountSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserAccountSuccessDto(
          email: json['email'],
          userId: json['userId'],
          groupId: json['groupId'],
          accessToken: json['accessToken'],
          isAdmin: json['isAdmin'],
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
