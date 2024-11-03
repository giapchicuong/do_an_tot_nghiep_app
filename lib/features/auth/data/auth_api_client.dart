import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/auth/dtos/register_dto.dart';
import 'package:do_an_tot_nghiep/features/auth/dtos/user_account_success_dto.dart';

import '../dtos/login_dto.dart';
import '../dtos/login_success_dto.dart';

class AuthApiClient {
  final DioClient dio;

  AuthApiClient(this.dio);

  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dio.post('/login', data: loginDto.toJson());
      final int ec = response.data['EC'];
      if (ec == 0) {
        return LoginSuccessDto.fromJson(response.data['DT']);
      }
      throw Exception(response.data['EM']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['EM']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> register(RegisterDto registerDto) async {
    try {
      final response = await dio.post('/register', data: registerDto.toJson());
      final int ec = response.data['EC'];
      if (ec != 0) {
        throw Exception(response.data['EM']);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['EM']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<UserAccountSuccessDto?> getUserAccount() async {
    try {
      final response = await dio.get('/account');
      if (response.statusCode == 200) {
        final int ec = response.data['EC'];
        if (ec == 0) {
          return UserAccountSuccessDto.fromJson(response.data['DT']);
        }
      }
      return null;
    } on DioException catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      final response = await dio.post('/logout');
      final int ec = response.data['EC'];
      if (ec == 0) return;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['EM']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
