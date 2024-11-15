List<UserPaymentMethodSuccessDto> listUserPaymentMethodSuccessDto(
        List<dynamic> data) =>
    List<UserPaymentMethodSuccessDto>.from(
        data.map((e) => UserPaymentMethodSuccessDto.fromJson(e)));

class UserPaymentMethodSuccessDto {
  final int methodId;
  final String methodName;

  UserPaymentMethodSuccessDto({
    required this.methodId,
    required this.methodName,
  });

  factory UserPaymentMethodSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserPaymentMethodSuccessDto(
        methodId: json['methodId'],
        methodName: json['methodName'],
      );
}
