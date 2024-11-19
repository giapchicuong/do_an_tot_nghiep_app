class UserPaymentDto {
  int durationId;
  int methodId;

  UserPaymentDto({
    required this.durationId,
    required this.methodId,
  });

  Map<String, dynamic> toJson() => {
        "durationId": durationId,
        "methodId": methodId,
      };
}
