import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_method_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';

import '../../result_type.dart';

class UserPaymentMethodGetBloc
    extends Bloc<UserPaymentMethodGetEvent, UserPaymentMethodGetState> {
  UserPaymentMethodGetBloc(this.userRepository)
      : super(UserPaymentMethodGetInitial()) {
    on<UserPaymentMethodGetStarted>(_onUserPaymentMethodGetStarted);
  }

  final UserRepository userRepository;

  void _onUserPaymentMethodGetStarted(UserPaymentMethodGetStarted event,
      Emitter<UserPaymentMethodGetState> emit) async {
    emit(UserPaymentMethodGetInProgress());
    final result = await userRepository.getUserPaymentMethod();

    return (switch (result) {
      Success(data: final data) =>
        emit(UserPaymentMethodGetSuccess(userPaymentMethodSuccessDto: data)),
      Failure() => emit(UserPaymentMethodGetFailure(result.message))
    });
  }
}
