import 'dart:developer';

import 'package:do_an_tot_nghiep/features/history/data/history_api_client.dart';
import 'package:do_an_tot_nghiep/features/history/dtos/history_user_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/history/dtos/history_user_update_get_success_dto.dart';

import '../../result_type.dart';

class HistoryRepository {
  final HistoryApiClient historyApiClient;

  HistoryRepository(this.historyApiClient);

  Future<Result<List<HistoryUserSuccessDto>>> getResultsReviewByUserId() async {
    try {
      final data = await historyApiClient.getResultsReviewByUserId();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<List<HistoryUserUpdateSuccessDto>>>
      getPaymentTransactionByUserId() async {
    try {
      final data = await historyApiClient.getPaymentTransactionByUserId();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }
}
