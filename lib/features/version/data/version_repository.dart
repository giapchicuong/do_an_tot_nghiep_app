import 'dart:developer';

import 'package:do_an_tot_nghiep/features/result_type.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_api_client.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/option_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/total_rating_avg_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_success_dto.dart';

class VersionRepository {
  final VersionApiClient versionApiClient;

  VersionRepository(this.versionApiClient);

  Future<Result<List<OptionRatingGetSuccessDto>>> getOptionRating() async {
    try {
      final data = await versionApiClient.getOptionRating();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<List<UserRatingSuccessDto>>> getUserRating() async {
    try {
      final data = await versionApiClient.getUserRating();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<TotalRatingAvgRatingGetSuccessDto>>
      getTotalRatingAvgRating() async {
    try {
      final data = await versionApiClient.getTotalRatingAvgRating();
      return Success(data);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }
}
