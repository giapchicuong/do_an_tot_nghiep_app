import 'package:do_an_tot_nghiep/features/version/dtos/total_rating_avg_rating_get_success_dto.dart';

sealed class TotalRatingAvgRatingGetState {}

class TotalRatingAvgRatingGetInitial extends TotalRatingAvgRatingGetState {}

class TotalRatingAvgRatingGetInProgress extends TotalRatingAvgRatingGetState {}

class TotalRatingAvgRatingGetSuccess extends TotalRatingAvgRatingGetState {
  final TotalRatingAvgRatingGetSuccessDto data;

  TotalRatingAvgRatingGetSuccess({required this.data});
}

class TotalRatingAvgRatingGetFailure extends TotalRatingAvgRatingGetState {
  final String msg;

  TotalRatingAvgRatingGetFailure(this.msg);
}
