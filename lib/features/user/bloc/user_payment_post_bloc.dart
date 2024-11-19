import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';

import '../../result_type.dart';

class UserPaymentPostBloc
    extends Bloc<UserPaymentPostEvent, UserPaymentPostState> {
  UserPaymentPostBloc(this.userRepository) : super(UserPaymentPostInitial()) {
    on<UserPaymentPostStarted>(_onUserPaymentPostStarted);
    on<UserPaymentPostSuccessEvent>(_onUserPaymentPostSuccessEvent);
    on<UserPaymentPostFailureEvent>(_onUserPaymentPostFailureEvent);
  }

  final UserRepository userRepository;

  void _onUserPaymentPostStarted(
      UserPaymentPostStarted event, Emitter<UserPaymentPostState> emit) async {
    emit(UserPaymentPostInProgress());
    final result = await userRepository.postUserPayment(
      durationId: event.durationId,
      methodId: event.methodId,
    );

    return (switch (result) {
      Success(data: final data) =>
        emit(UserPaymentPostSuccess(userPaymentSuccessDto: data)),
      Failure() => emit(UserPaymentPostFailure(result.message))
    });
  }

  void _onUserPaymentPostSuccessEvent(UserPaymentPostSuccessEvent event,
      Emitter<UserPaymentPostState> emit) async {
    emit(UserPaymentPostResultSuccess());
  }

  void _onUserPaymentPostFailureEvent(UserPaymentPostFailureEvent event,
      Emitter<UserPaymentPostState> emit) async {
    emit(UserPaymentPostResultFailure(event.msg));
  }
}
