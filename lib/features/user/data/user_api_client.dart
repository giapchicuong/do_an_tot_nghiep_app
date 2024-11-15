import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_duration_option_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_payment_method_success_dto.dart';

class UserApiClient {
  final DioClient dio;

  UserApiClient(this.dio);

  Future<UserAccountGetSuccessDto> getAccountInfor() async {
    try {
      final response = await dio.get('/user/getAccountInfo');
      final int ec = response.data['EC'];
      if (response.statusCode == 200) {
        if (ec == 0) {
          return UserAccountGetSuccessDto.fromJson(response.data['DT']);
        }
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

  Future<List<UserDurationOptionSuccessDto>> getUserDurationOption() async {
    try {
      final response = await dio.get('/durationOption/read');
      final int ec = response.data['EC'];
      if (response.statusCode == 200) {
        if (ec == 0) {
          return listUserDurationOptionSuccessDto(response.data['DT']);
        }
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

  Future<List<UserPaymentMethodSuccessDto>> getUserPaymentMethod() async {
    try {
      final response = await dio.get('/paymentMethod/read');
      final int ec = response.data['EC'];
      if (response.statusCode == 200) {
        if (ec == 0) {
          return listUserPaymentMethodSuccessDto(response.data['DT']);
        }
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
}
