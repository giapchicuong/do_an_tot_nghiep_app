import 'dart:developer';

import 'package:do_an_tot_nghiep/features/user/data/user_api_client.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';

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
}
