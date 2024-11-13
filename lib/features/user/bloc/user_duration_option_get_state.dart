import '../dtos/user_duration_option_success_dto.dart';

sealed class UserDurationOptionGetState {}

class UserDurationOptionGetInitial extends UserDurationOptionGetState {}

class UserDurationOptionGetInProgress extends UserDurationOptionGetState {}

class UserDurationOptionGetSuccess extends UserDurationOptionGetState {
  final List<UserDurationOptionSuccessDto> userDurationOptionSuccessDto;

  UserDurationOptionGetSuccess({required this.userDurationOptionSuccessDto});
}

class UserDurationOptionGetFailure extends UserDurationOptionGetState {
  final String msg;

  UserDurationOptionGetFailure(this.msg);
}
