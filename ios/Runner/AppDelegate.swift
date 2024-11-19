import Flutter
import UIKit
import zpdk

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // ...

    let controller = window.rootViewController as? FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: "flutter.native/channelPayOrder",
                                             binaryMessenger: controller!.binaryMessenger)
    nativeChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == MethodNames.methodPayOrder else {
          result(FlutterMethodNotImplemented)
          return
        }

        let args = call.arguments as? [String: Any]
        let _zptoken = args?["zptoken"] as? String

        ZalopaySDK.sharedInstance()?.payOrder(_zptoken)
         result("Processing...")
    })
  }

    // Khởi tạo FlutterEventChannel để xử lý các sự kiện
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // ...
      let eventPayOrderChannel = FlutterEventChannel(name: "flutter.native/eventPayOrder",
                                                   binaryMessenger: controller!.binaryMessenger)
      eventPayOrderChannel.setStreamHandler(self)
    }

    // Gửi sự kiện tới Flutter qua FlutterEventSink
    private var eventSink: FlutterEventSink?
    func paymentDidSucceeded(_ transactionId: String!, zpTranstoken: String!, appTransId: String!) {
      guard let eventSink = eventSink else {
        return
      }
      eventSink(["errorCode": 1, "zpTranstoken": zpTranstoken, "transactionId": transactionId, "appTransId": appTransId])
    }

    func paymentDidCanceled(_ zpTranstoken: String!, appTransId: String!) {
      guard let eventSink = eventSink else {
        return
      }
      eventSink(["errorCode": 4, "zpTranstoken": zpTranstoken, "appTransId": appTransId])
    }

    func paymentDidError(_ errorCode: ZPPaymentErrorCode, zpTranstoken: String!, appTransId: String!) {
      guard let eventSink = eventSink else {
        return
      }
      eventSink(["errorCode": errorCode, "zpTranstoken": zpTranstoken, "appTransId": appTransId])
    }
}
