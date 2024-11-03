import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_account_infor_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_account_infor_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';

import '../../result_type.dart';

class UserAccountInforGetBloc
    extends Bloc<UserAccountInforGetEvent, UserAccountInforGetState> {
  UserAccountInforGetBloc(this.userRepository)
      : super(UserAccountInforGetInitial()) {
    on<UserAccountInforGetStarted>(_onUserAccountInforGetStarted);
  }

  final UserRepository userRepository;

  void _onUserAccountInforGetStarted(UserAccountInforGetStarted event,
      Emitter<UserAccountInforGetState> emit) async {
    emit(UserAccountInforGetInProgress());
    final result = await userRepository.getAccountInfor();

    return (switch (result) {
      Success(data: final data) =>
        emit(UserAccountInforGetSuccess(userAccountGetSuccessDto: data)),
      Failure() => emit(UserAccountInforGetFailure(result.message))
    });
  }
}
