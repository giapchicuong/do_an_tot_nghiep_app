import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/total_rating_avg_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/total_rating_avg_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/data/version_repository.dart';

import '../../result_type.dart';

class TotalRatingAvgRatingGetBloc
    extends Bloc<TotalRatingAvgRatingGetEvent, TotalRatingAvgRatingGetState> {
  TotalRatingAvgRatingGetBloc(this.versionRepository)
      : super(TotalRatingAvgRatingGetInitial()) {
    on<TotalRatingAvgRatingGetStarted>(_onTotalRatingAvgRatingGetStarted);
  }

  final VersionRepository versionRepository;

  void _onTotalRatingAvgRatingGetStarted(TotalRatingAvgRatingGetStarted event,
      Emitter<TotalRatingAvgRatingGetState> emit) async {
    emit(TotalRatingAvgRatingGetInProgress());

    final result = await versionRepository.getTotalRatingAvgRating();

    return (switch (result) {
      Success(data: final data) =>
        emit(TotalRatingAvgRatingGetSuccess(data: data)),
      Failure() => emit(TotalRatingAvgRatingGetFailure(result.message))
    });
  }
}
