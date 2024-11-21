import 'package:bloc/bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_payment_post_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';

import '../../result_type.dart';

class UserPaymentPostBloc
    extends Bloc<UserPaymentPostEvent, UserPaymentPostState> {
  UserPaymentPostBloc(this.userRepository) : super(UserPaymentPostInitial()) {
    on<UserPaymentPostStarted>(_onUserPaymentPostStarted);
    on<UserCheckStatusPaymentPostStarted>(_onUserCheckStatusPayment);
    on<UserPaymentOpenUrlPostStarted>(_onUserPaymentOpenUrl);
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

  void _onUserCheckStatusPayment(UserCheckStatusPaymentPostStarted event,
      Emitter<UserPaymentPostState> emit) async {
    emit(UserCheckStatusPaymentInProgress());
    final result = await userRepository.postCheckStatusPayment(
        appTransId: event.appTransId);

    return (switch (result) {
      Success(data: final data) when data.returnCode == 1 => emit(
          UserCheckStatusPaymentSuccess(
              isPaymentSuccess: true, isWaiting: false),
        ),
      Success(data: final data) when data.returnCode == 2 => emit(
          UserCheckStatusPaymentSuccess(
              isPaymentSuccess: false, isWaiting: false),
        ),
      Success(data: final data) when data.returnCode == 3 => emit(
          UserCheckStatusPaymentSuccess(
              isPaymentSuccess: false, isWaiting: true),
        ),
      Success() => UserCheckStatusPaymentSuccess(
          isPaymentSuccess: false, isWaiting: false),
      Failure() => emit(UserCheckStatusPaymentFailure(result.message)),
    });
  }

  void _onUserPaymentOpenUrl(UserPaymentOpenUrlPostStarted event,
      Emitter<UserPaymentPostState> emit) async {
    emit(UserPaymentPostInProgress());
    await userRepository.openlaunchUrl(event.orderUrl);
  }
}
