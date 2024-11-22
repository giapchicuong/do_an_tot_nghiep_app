List<HistoryUserSuccessDto> historyUserSuccessDtoFromJson(List<dynamic> data) =>
    List<HistoryUserSuccessDto>.from(
        data.map((x) => HistoryUserSuccessDto.fromJson(x)));

class HistoryUserSuccessDto {
  String ratingName;
  String ratingValue;
  String imageUrl;
  DateTime createdAt;

  HistoryUserSuccessDto({
    required this.ratingName,
    required this.ratingValue,
    required this.imageUrl,
    required this.createdAt,
  });

  factory HistoryUserSuccessDto.fromJson(Map<String, dynamic> json) =>
      HistoryUserSuccessDto(
        ratingName: json["ratingName"],
        ratingValue: json["ratingValue"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
