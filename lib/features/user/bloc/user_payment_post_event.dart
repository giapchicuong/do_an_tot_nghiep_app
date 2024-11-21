abstract class UserPaymentPostEvent {}

class UserPaymentPostStarted extends UserPaymentPostEvent {
  final int durationId;
  final int methodId;

  UserPaymentPostStarted({
    required this.durationId,
    required this.methodId,
  });
}

class UserCheckStatusPaymentPostStarted extends UserPaymentPostEvent {
  final String appTransId;

  UserCheckStatusPaymentPostStarted({required this.appTransId});
}

class UserPaymentOpenUrlPostStarted extends UserPaymentPostEvent {
  final String orderUrl;

  UserPaymentOpenUrlPostStarted({required this.orderUrl});
}
