List<OptionRatingGetSuccessDto> listOptionRatingGetSuccessDtoFromJson(
        List<dynamic> data) =>
    List<OptionRatingGetSuccessDto>.from(
        data.map((e) => OptionRatingGetSuccessDto.fromJson(e)));

class OptionRatingGetSuccessDto {
  final int reviewOptionId;
  final String reviewOptionName;

  OptionRatingGetSuccessDto(
      {required this.reviewOptionId, required this.reviewOptionName});

  factory OptionRatingGetSuccessDto.fromJson(Map<String, dynamic> json) =>
      OptionRatingGetSuccessDto(
        reviewOptionId: json['reviewOptionId'],
        reviewOptionName: json['reviewOptionName'],
      );
}
