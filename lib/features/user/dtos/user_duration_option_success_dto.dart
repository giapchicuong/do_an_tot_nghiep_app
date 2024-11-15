List<UserDurationOptionSuccessDto> listUserDurationOptionSuccessDto(
        List<dynamic> data) =>
    List<UserDurationOptionSuccessDto>.from(
        data.map((e) => UserDurationOptionSuccessDto.fromJson(e)));

class UserDurationOptionSuccessDto {
  final int durationId;
  final String durationName;
  final int durationTime;
  final int durationPrice;

  UserDurationOptionSuccessDto({
    required this.durationId,
    required this.durationName,
    required this.durationTime,
    required this.durationPrice,
  });

  factory UserDurationOptionSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserDurationOptionSuccessDto(
        durationId: json['durationId'],
        durationName: json['durationName'],
        durationTime: json['durationTime'],
        durationPrice: json['durationPrice'],
      );
}
