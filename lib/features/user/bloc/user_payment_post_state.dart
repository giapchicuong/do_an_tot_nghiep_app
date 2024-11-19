import '../dtos/user_payment_success_dto.dart';

sealed class UserPaymentPostState {}

class UserPaymentPostInitial extends UserPaymentPostState {}

class UserPaymentPostResultInProgress extends UserPaymentPostState {}

class UserPaymentPostResultSuccess extends UserPaymentPostState {}

class UserPaymentPostResultFailure extends UserPaymentPostState {
  final String msg;

  UserPaymentPostResultFailure(this.msg);
}

class UserPaymentPostInProgress extends UserPaymentPostState {}

class UserPaymentPostSuccess extends UserPaymentPostState {
  final UserPaymentSuccessDto userPaymentSuccessDto;

  UserPaymentPostSuccess({required this.userPaymentSuccessDto});
}

class UserPaymentPostFailure extends UserPaymentPostState {
  final String msg;

  UserPaymentPostFailure(this.msg);
}
