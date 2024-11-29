import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_add_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_success_dto.dart';

sealed class UserRatingGetState {}

class UserRatingGetInitial extends UserRatingGetState {}

class UserRatingGetInProgress extends UserRatingGetState {}

class UserRatingGetSuccess extends UserRatingGetState {
  final UserRatingSuccessDto data;
  final List<ReviewOptions> reviewOptions;
  final int rating;
  final bool isRating;
  UserRatingGetSuccess(
      {required this.data,
      required this.rating,
      required this.reviewOptions,
      required this.isRating});
}

class UserRatingGetFailure extends UserRatingGetState {
  final String msg;

  UserRatingGetFailure(this.msg);
}

class UserRatingAddSuccess extends UserRatingGetState {
  final List<UserRatingSuccessDto> data;

  UserRatingAddSuccess({required this.data});
}
