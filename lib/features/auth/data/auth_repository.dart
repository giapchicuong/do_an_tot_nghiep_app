import 'dart:developer';

import 'package:do_an_tot_nghiep/features/auth/data/auth_local_data_source.dart';
import 'package:do_an_tot_nghiep/features/auth/dtos/register_dto.dart';
import 'package:do_an_tot_nghiep/features/auth/dtos/user_account_success_dto.dart';

import '../../result_type.dart';
import '../dtos/login_dto.dart';
import 'auth_api_client.dart';

class AuthRepository {
  final AuthApiClient authApiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepository({
    required this.authApiClient,
    required this.authLocalDataSource,
  });

  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginSuccessDto =
          await authApiClient.login(LoginDto(email: email, password: password));
      await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      await authApiClient.register(RegisterDto(
          fullName: fullName, email: email, phone: phone, password: password));
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<UserAccountSuccessDto?>> getUserAccount() async {
    try {
      final data = await authApiClient.getUserAccount();
      if (data != null) {
        return Success(data);
      }
      return Success(null);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<void>> logout() async {
    try {
      await authApiClient.logOut();
      await authLocalDataSource.deleteToken();
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }
}
