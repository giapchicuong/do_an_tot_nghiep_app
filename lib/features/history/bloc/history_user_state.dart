import 'package:do_an_tot_nghiep/features/history/dtos/history_user_get_success_dto.dart';

sealed class HistoryUserGetState {}

class HistoryUserGetInitial extends HistoryUserGetState {}

class HistoryUserGetInProgress extends HistoryUserGetState {}

class HistoryUserGetSuccess extends HistoryUserGetState {
  final List<HistoryUserSuccessDto> historyUserSuccessDto;

  HistoryUserGetSuccess({required this.historyUserSuccessDto});
}

class HistoryUserGetFailure extends HistoryUserGetState {
  final String msg;

  HistoryUserGetFailure(this.msg);
}
