import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_repository.dart';

import '../../result_type.dart';
import 'history_user_event.dart';
import 'history_user_state.dart';

class HistoryUserGetBloc
    extends Bloc<HistoryUserGetEvent, HistoryUserGetState> {
  HistoryUserGetBloc(this.historyRepository) : super(HistoryUserGetInitial()) {
    on<HistoryUserGetStarted>(_onHistoryUserGetStarted);
  }

  final HistoryRepository historyRepository;

  void _onHistoryUserGetStarted(
      HistoryUserGetStarted event, Emitter<HistoryUserGetState> emit) async {
    emit(HistoryUserGetInProgress());
    final result = await historyRepository.getResultsReviewByUserId();

    return (switch (result) {
      Success(data: final data) =>
        emit(HistoryUserGetSuccess(historyUserSuccessDto: data)),
      Failure() => emit(HistoryUserGetFailure(result.message))
    });
  }
}
