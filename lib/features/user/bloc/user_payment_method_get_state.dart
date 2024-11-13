import '../dtos/user_payment_method_success_dto.dart';

sealed class UserPaymentMethodGetState {}

class UserPaymentMethodGetInitial extends UserPaymentMethodGetState {}

class UserPaymentMethodGetInProgress extends UserPaymentMethodGetState {}

class UserPaymentMethodGetSuccess extends UserPaymentMethodGetState {
  final List<UserPaymentMethodSuccessDto> userPaymentMethodSuccessDto;

  UserPaymentMethodGetSuccess({required this.userPaymentMethodSuccessDto});
}

class UserPaymentMethodGetFailure extends UserPaymentMethodGetState {
  final String msg;

  UserPaymentMethodGetFailure(this.msg);
}
