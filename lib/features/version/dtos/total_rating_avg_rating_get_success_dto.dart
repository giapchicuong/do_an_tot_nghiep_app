class TotalRatingAvgRatingGetSuccessDto {
  final int totalRating;
  final String avgRating;
  final int versionId;
  final String nameVersion;
  final DateTime createdAt;

  TotalRatingAvgRatingGetSuccessDto(
      {required this.totalRating,
      required this.avgRating,
      required this.versionId,
      required this.nameVersion,
      required this.createdAt});

  factory TotalRatingAvgRatingGetSuccessDto.fromJson(
          Map<String, dynamic> json) =>
      TotalRatingAvgRatingGetSuccessDto(
        totalRating: json['totalRating'],
        avgRating: json['avgRating'],
        versionId: json['versionId'],
        nameVersion: json['nameVersion'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}
