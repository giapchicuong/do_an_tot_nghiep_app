import '../dtos/history_user_update_get_success_dto.dart';

sealed class HistoryUserUpdateGetState {}

class HistoryUserUpdateGetInitial extends HistoryUserUpdateGetState {}

class HistoryUserUpdateGetInProgress extends HistoryUserUpdateGetState {}

class HistoryUserUpdateGetSuccess extends HistoryUserUpdateGetState {
  final List<HistoryUserUpdateSuccessDto> historyUserUpdateSuccessDto;

  HistoryUserUpdateGetSuccess({required this.historyUserUpdateSuccessDto});
}

class HistoryUserUpdateGetFailure extends HistoryUserUpdateGetState {
  final String msg;

  HistoryUserUpdateGetFailure(this.msg);
}
