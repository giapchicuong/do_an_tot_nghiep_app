import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_account_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_check_status_payment_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_duration_option_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_payment_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_payment_method_success_dto.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_payment_success_dto.dart';

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

  Future<UserPaymentSuccessDto> postUserPayment(
      {required UserPaymentDto data}) async {
    try {
      final response = await dio.post('/payment', data: data.toJson());
      final int returnCode = response.data['return_code'];
      if (response.statusCode == 200) {
        if (returnCode == 1) {
          return UserPaymentSuccessDto.fromJson(response.data);
        }
      }
      throw Exception(response.data['return_message']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['return_message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<UserCheckStatusPaymentSuccessDto> postCheckStatusPayment(
      {required String appTransId}) async {
    try {
      final response = await dio
          .post('/check-status-order', data: {"app_trans_id":appTransId});
      if (response.statusCode == 200) {
        return UserCheckStatusPaymentSuccessDto.fromJson(response.data);
      }
      throw Exception(response.data['return_message']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['return_message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
