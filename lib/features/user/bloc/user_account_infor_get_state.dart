import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';

sealed class UserAccountInforGetState {}

class UserAccountInforGetInitial extends UserAccountInforGetState {}

class UserAccountInforGetInProgress extends UserAccountInforGetState {}

class UserAccountInforGetSuccess extends UserAccountInforGetState {
  final UserAccountGetSuccessDto userAccountGetSuccessDto;

  UserAccountInforGetSuccess({required this.userAccountGetSuccessDto});
}

class UserAccountInforGetFailure extends UserAccountInforGetState {
  final String msg;

  UserAccountInforGetFailure(this.msg);
}
