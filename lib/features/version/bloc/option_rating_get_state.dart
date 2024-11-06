import 'package:do_an_tot_nghiep/features/version/dtos/option_rating_get_success_dto.dart';

sealed class OptionRatingGetState {}

class OptionRatingGetInitial extends OptionRatingGetState {}

class OptionRatingGetInProgress extends OptionRatingGetState {}

class OptionRatingGetSuccess extends OptionRatingGetState {
  final List<OptionRatingGetSuccessDto> data;

  OptionRatingGetSuccess({required this.data});
}

class OptionRatingGetFailure extends OptionRatingGetState {
  final String msg;

  OptionRatingGetFailure(this.msg);
}
