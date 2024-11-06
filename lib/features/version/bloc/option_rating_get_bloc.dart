import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/option_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/option_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_repository.dart';

import '../../result_type.dart';

class OptionRatingGetBloc
    extends Bloc<OptionRatingGetEvent, OptionRatingGetState> {
  OptionRatingGetBloc(this.versionRepository)
      : super(OptionRatingGetInitial()) {
    on<OptionRatingGetStarted>(_onOptionRatingGetStarted);
  }

  final VersionRepository versionRepository;

  void _onOptionRatingGetStarted(
      OptionRatingGetStarted event, Emitter<OptionRatingGetState> emit) async {
    emit(OptionRatingGetInProgress());

    final result = await versionRepository.getOptionRating();

    return (switch (result) {
      Success(data: final data) => emit(OptionRatingGetSuccess(data: data)),
      Failure() => emit(OptionRatingGetFailure(result.message))
    });
  }
}
