import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/history/dtos/history_user_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/history/dtos/history_user_update_get_success_dto.dart';

class HistoryApiClient {
  final DioClient dio;

  HistoryApiClient(this.dio);
  Future<List<HistoryUserSuccessDto>> getResultsReviewByUserId() async {
    try {
      final response = await dio.get('/resultReview/getResultsReviewByUserId');
      if (response.statusCode == 200) {
        final int ec = response.data['EC'];
        if (ec == 0) {
          return historyUserSuccessDtoFromJson(response.data['DT']);
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

  Future<List<HistoryUserUpdateSuccessDto>>
      getPaymentTransactionByUserId() async {
    try {
      final response =
          await dio.get('/paymentTransaction/getPaymentTransactionByUserId');
      if (response.statusCode == 200) {
        final int ec = response.data['EC'];
        if (ec == 0) {
          return historyUserUpdateSuccessDto(response.data['DT']);
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
