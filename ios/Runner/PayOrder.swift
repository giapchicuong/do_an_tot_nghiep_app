//Depend on where you handle ZPPaymentDelegate.
ZalopaySDK.sharedInstance()?.paymentDelegate = self

ZalopaySDK.sharedInstance()?.payOrder(zpTransToken.text)

func paymentDidSucceeded(_ transactionId: String!, zpTranstoken: String!, appTransId: String!) {
  //Xử lý trường hợp thanh toán thành công
}

func paymentDidCanceled(_ zpTranstoken: String!, appTransId: String!) {
  //Xử lý trường hợp người dùng từ chối thanh toán
}


func paymentDidError(_ errorCode: ZPPaymentErrorCode, zpTranstoken : String!, appTransId: String!) {
  if (errorCode == .appNotInstall) {
    //Gọi hàm này để điều hướng đến tải ứng dụng Zalo trên AppStore
    ZalopaySDK.sharedInstance()?.navigateToZaloStore();

    //HOẶC gọi hàm này để điều hướng đến tải Ứng dụng Zalopay trên AppStore
    ZalopaySDK.sharedInstance()?.navigateToZalopayStore();
    return;
  }
}