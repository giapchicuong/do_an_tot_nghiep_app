import '../dtos/user_payment_success_dto.dart';

sealed class UserPaymentPostState {}

class UserPaymentPostInitial extends UserPaymentPostState {}

class UserPaymentPostInProgress extends UserPaymentPostState {}

class UserPaymentPostSuccess extends UserPaymentPostState {
  final UserPaymentSuccessDto userPaymentSuccessDto;

  UserPaymentPostSuccess({required this.userPaymentSuccessDto});
}

class UserPaymentPostFailure extends UserPaymentPostState {
  final String msg;

  UserPaymentPostFailure(this.msg);
}

class UserCheckStatusPaymentInProgress extends UserPaymentPostState {}

class UserCheckStatusPaymentSuccess extends UserPaymentPostState {
  final bool isPaymentSuccess;
  final bool isWaiting;

  UserCheckStatusPaymentSuccess(
      {required this.isPaymentSuccess, required this.isWaiting});
}

class UserCheckStatusPaymentFailure extends UserPaymentPostState {
  final String msg;

  UserCheckStatusPaymentFailure(this.msg);
}
