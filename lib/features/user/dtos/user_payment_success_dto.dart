class UserPaymentSuccessDto {
  int returnCode;
  String returnMessage;
  int subReturnCode;
  String subReturnMessage;
  String zpTransToken;
  String orderUrl;
  String orderToken;
  String appTransId;

  UserPaymentSuccessDto({
    required this.returnCode,
    required this.returnMessage,
    required this.subReturnCode,
    required this.subReturnMessage,
    required this.zpTransToken,
    required this.orderUrl,
    required this.orderToken,
    required this.appTransId,
  });

  factory UserPaymentSuccessDto.fromJson(Map<String, dynamic> json) =>
      UserPaymentSuccessDto(
        returnCode: json["return_code"],
        returnMessage: json["return_message"],
        subReturnCode: json["sub_return_code"],
        subReturnMessage: json["sub_return_message"],
        zpTransToken: json["zp_trans_token"],
        orderUrl: json["order_url"],
        orderToken: json["order_token"],
        appTransId: json["app_trans_id"],
      );
}
