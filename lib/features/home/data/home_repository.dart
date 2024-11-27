import 'dart:developer';

import 'package:do_an_tot_nghiep/features/home/data/home_api_client.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/result_review_dto.dart';
import 'package:do_an_tot_nghiep/features/home/dtos/upload_image_success_dto.dart';

import '../../result_type.dart';
import '../dtos/upload_image_dto.dart';

class HomeRepository {
  final HomeApiClient homeApiClient;

  HomeRepository({required this.homeApiClient});

  //Upload Image
  Future<Result<UploadImageSuccessDto>> uploadImage(
      {required UploadImageDto uploadImageDto}) async {
    try {
      final uploadImageSuccessDto =
          await homeApiClient.uploadImage(uploadImageDto: uploadImageDto);
      return Success(uploadImageSuccessDto);
    } catch (e) {
      log('Error $e');
      return Failure('$e');
    }
  }

  Future<Result<void>> postResultReview(
      {required String ratingValue,
      required String ratingName,
      required String imageUrl}) async {
    try {
      await homeApiClient.postResultReview(
          resultReviewDto: ResultReviewDto(
        ratingValue: ratingValue,
        ratingName: ratingName,
        imageUrl: imageUrl,
      ));
      return Success(null);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }
}
