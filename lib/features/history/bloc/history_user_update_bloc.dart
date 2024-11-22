import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_repository.dart';

import '../../result_type.dart';
import 'history_user_update_event.dart';
import 'history_user_update_state.dart';

class HistoryUserUpdateGetBloc
    extends Bloc<HistoryUserUpdateGetEvent, HistoryUserUpdateGetState> {
  HistoryUserUpdateGetBloc(this.historyRepository)
      : super(HistoryUserUpdateGetInitial()) {
    on<HistoryUserUpdateGetStarted>(_onHistoryUserUpdateGetStarted);
  }

  final HistoryRepository historyRepository;

  void _onHistoryUserUpdateGetStarted(HistoryUserUpdateGetStarted event,
      Emitter<HistoryUserUpdateGetState> emit) async {
    emit(HistoryUserUpdateGetInProgress());
    final result = await historyRepository.getPaymentTransactionByUserId();

    return (switch (result) {
      Success(data: final data) =>
        emit(HistoryUserUpdateGetSuccess(historyUserUpdateSuccessDto: data)),
      Failure() => emit(HistoryUserUpdateGetFailure(result.message))
    });
  }
}
