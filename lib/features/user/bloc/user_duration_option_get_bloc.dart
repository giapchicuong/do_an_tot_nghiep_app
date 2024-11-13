import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_duration_option_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_duration_option_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';

import '../../result_type.dart';

class UserDurationOptionGetBloc
    extends Bloc<UserDurationOptionGetEvent, UserDurationOptionGetState> {
  UserDurationOptionGetBloc(this.userRepository)
      : super(UserDurationOptionGetInitial()) {
    on<UserDurationOptionGetStarted>(_onUserDurationOptionGetStarted);
  }

  final UserRepository userRepository;

  void _onUserDurationOptionGetStarted(UserDurationOptionGetStarted event,
      Emitter<UserDurationOptionGetState> emit) async {
    emit(UserDurationOptionGetInProgress());
    final result = await userRepository.getUserDurationOption();

    return (switch (result) {
      Success(data: final data) =>
        emit(UserDurationOptionGetSuccess(userDurationOptionSuccessDto: data)),
      Failure() => emit(UserDurationOptionGetFailure(result.message))
    });
  }
}
