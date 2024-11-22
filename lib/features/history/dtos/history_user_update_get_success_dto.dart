List<HistoryUserUpdateSuccessDto> historyUserUpdateSuccessDto(
        List<dynamic> data) =>
    List<HistoryUserUpdateSuccessDto>.from(
        data.map((x) => HistoryUserUpdateSuccessDto.fromJson(x)));

class HistoryUserUpdateSuccessDto {
  String methodName;
  String statusName;
  int amount;
  int durationTime;
  String durationName;
  DateTime timeStart;
  DateTime timeEnd;
  DateTime createdAt;

  HistoryUserUpdateSuccessDto({
    required this.methodName,
    required this.statusName,
    required this.amount,
    required this.durationTime,
    required this.durationName,
    required this.timeStart,
    required this.timeEnd,
    required this.createdAt,
  });

  factory HistoryUserUpdateSuccessDto.fromJson(Map<String, dynamic> json) =>
      HistoryUserUpdateSuccessDto(
        methodName: json["methodName"],
        statusName: json["statusName"],
        amount: json["amount"],
        durationTime: json["durationTime"],
        durationName: json["durationName"],
        timeStart: DateTime.parse(json["timeStart"]),
        timeEnd: DateTime.parse(json["timeEnd"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
