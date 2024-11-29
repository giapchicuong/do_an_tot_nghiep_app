import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/option_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/total_rating_avg_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_add_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/user_rating_success_dto.dart';

class VersionApiClient {
  final DioClient dio;

  VersionApiClient(this.dio);

  Future<List<OptionRatingGetSuccessDto>> getOptionRating() async {
    try {
      final response = await dio.get('/reviewVersion/getOptionRating');
      final int ec = response.data['EC'];
      if (ec == 0) {
        return listOptionRatingGetSuccessDtoFromJson(response.data['DT']);
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

  Future<UserRatingSuccessDto> getUserRating() async {
    try {
      final response = await dio.get('/reviewVersion/getListUserRating');
      final int ec = response.data['EC'];
      if (ec == 0) {
        return UserRatingSuccessDto.fromJson(response.data['DT']);
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

  Future<TotalRatingAvgRatingGetSuccessDto> getTotalRatingAvgRating() async {
    try {
      final response =
          await dio.get('/reviewVersion/getVersionTotalRatingAndAvgRating');
      final int ec = response.data['EC'];
      if (ec == 0) {
        return TotalRatingAvgRatingGetSuccessDto.fromJson(response.data['DT']);
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

  Future<UserRatingSuccessDto> addOptionRating(
      {required UserRatingAdDto data}) async {
    try {
      final response = await dio.post(
        '/reviewVersion/create',
        data: data.toJson(),
      );
      final int ec = response.data['EC'];
      if (ec == 0) {
        return UserRatingSuccessDto.fromJson(response.data['DT']);
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
