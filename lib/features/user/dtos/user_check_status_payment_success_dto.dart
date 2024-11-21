class UserCheckStatusPaymentSuccessDto {
  int returnCode;
  String returnMessage;
  int subReturnCode;
  String subReturnMessage;
  bool isProcessing;
  int amount;
  int zpTransId;
  int discountAmount;

  UserCheckStatusPaymentSuccessDto({
    required this.returnCode,
    required this.returnMessage,
    required this.subReturnCode,
    required this.subReturnMessage,
    required this.isProcessing,
    required this.amount,
    required this.zpTransId,
    required this.discountAmount,
  });

  factory UserCheckStatusPaymentSuccessDto.fromJson(
          Map<String, dynamic> json) =>
      UserCheckStatusPaymentSuccessDto(
        returnCode: json["return_code"],
        returnMessage: json["return_message"],
        subReturnCode: json["sub_return_code"],
        subReturnMessage: json["sub_return_message"],
        isProcessing: json["is_processing"],
        amount: json["amount"],
        zpTransId: json["zp_trans_id"],
        discountAmount: json["discount_amount"],
      );
}
