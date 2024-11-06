import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_success_dto.dart';

sealed class UserRatingGetState {}

class UserRatingGetInitial extends UserRatingGetState {}

class UserRatingGetInProgress extends UserRatingGetState {}

class UserRatingGetSuccess extends UserRatingGetState {
  final List<UserRatingSuccessDto> data;

  UserRatingGetSuccess({required this.data});
}

class UserRatingGetFailure extends UserRatingGetState {
  final String msg;

  UserRatingGetFailure(this.msg);
}
