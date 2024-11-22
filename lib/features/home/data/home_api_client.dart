import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:do_an_tot_nghiep/configs/http_client.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/result_review_dto.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/upload_image_dto.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/upload_image_success_dto.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';

class HomeApiClient {
  final DioClient dio;

  HomeApiClient(this.dio);

  Future<UploadImageSuccessDto> uploadImage(
      {required UploadImageDto uploadImageDto}) async {
    FormData formData = FormData.fromMap(uploadImageDto.toJson());
    try {
      final response = await dio.post('/upload-image', data: formData);
      final int ec = response.data['EC'];
      if (response.statusCode == 200) {
        if (ec == 0) {
          final responseGet = await dio.get(response.data['DT'],
              options: Options(responseType: ResponseType.bytes));
          return UploadImageSuccessDto(
              imageName:
                  AppFormatter.extractFilenameFromUrl(response.data['DT']),
              image: base64Encode(responseGet.data));
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

  Future<void> postResultReview(
      {required ResultReviewDto resultReviewDto}) async {
    try {
      final response = await dio.post('/resultReview/create',
          data: resultReviewDto.toJson());
      if (response.statusCode != 200) {
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
}
