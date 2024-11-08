abstract class UserRatingGetEvent {}

class UserRatingGetStarted extends UserRatingGetEvent {}

class UserRatingAddStarted extends UserRatingGetEvent {
  final int userId;
  final int versionId;

  UserRatingAddStarted({required this.userId, required this.versionId});
}

class UserRatingPostStarted extends UserRatingGetEvent {
  final int? rating;
  final int? reviewOptionid;

  UserRatingPostStarted({this.rating, this.reviewOptionid});
}
