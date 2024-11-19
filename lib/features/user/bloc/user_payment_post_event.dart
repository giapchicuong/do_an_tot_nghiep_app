abstract class UserPaymentPostEvent {}

class UserPaymentPostSuccessEvent extends UserPaymentPostEvent {}

class UserPaymentPostFailureEvent extends UserPaymentPostEvent {
  final String msg;

  UserPaymentPostFailureEvent({required this.msg});
}

class UserPaymentPostStarted extends UserPaymentPostEvent {
  final int durationId;
  final int methodId;

  UserPaymentPostStarted({
    required this.durationId,
    required this.methodId,
  });
}
