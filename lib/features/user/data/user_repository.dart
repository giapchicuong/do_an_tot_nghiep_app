import 'dart:developer';

import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_duration_option_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_payment_method_success_dto.dart';

import '../../result_type.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository(this.userApiClient);

  Future<Result<UserAccountGetSuccessDto>> getAccountInfor() async {
    try {
      final data = await userApiClient.getAccountInfor();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<List<UserDurationOptionSuccessDto>>>
      getUserDurationOption() async {
    try {
      final data = await userApiClient.getUserDurationOption();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<List<UserPaymentMethodSuccessDto>>>
      getUserPaymentMethod() async {
    try {
      final data = await userApiClient.getUserPaymentMethod();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }
}
