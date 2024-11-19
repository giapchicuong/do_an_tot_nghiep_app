package com.example.do_an_tot_nghiep_app
import android.os.Bundle
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener
import vn.zalopay.sdk.ZaloPayError

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/channelPayOrder"
    private var _eventSink: EventChannel.EventSink? = null  // Khai báo _eventSink

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        configureFlutterEngine(flutterEngine!!)
    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel for handling payment
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "payOrder") {
                    val token = call.argument<String>("zptoken")
                    token?.let {
                        ZaloPaySDK.getInstance().payOrder(this@MainActivity, it, "demozpdk://app", object : PayOrderListener {
                            override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                                result.success("User Canceled")
                            }

                            override fun onPaymentError(zaloPayErrorCode: ZaloPayError?, zpTransToken: String?, appTransID: String?) {
                                result.success("Payment failed")
                            }

                            override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                                result.success("Payment Success")
                            }
                        })
                    } ?: run {
                        result.success("Token is null")
                    }
                }
            }

        // EventChannel for streaming payment status
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter.native/eventPayOrder")
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
                    _eventSink = eventSink
                }

                override fun onCancel(arguments: Any?) {
                    _eventSink = null
                }
            })

        // Another MethodChannel for handling payment
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "payOrder") {
                    val token = call.argument<String>("zptoken")
                    token?.let {
                        ZaloPaySDK.getInstance().payOrder(this@MainActivity, it, "demozpdk://app", object : PayOrderListener {
                            override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                                _eventSink?.success(mapOf(
                                    "errorCode" to "PAYMENTCANCELED",
                                    "zpTransToken" to zpTransToken,
                                    "appTransID" to appTransID
                                ))
                            }

                            override fun onPaymentError(zaloPayErrorCode: ZaloPayError?, zpTransToken: String?, appTransID: String?) {
                                _eventSink?.success(mapOf(
                                    "errorCode" to "PAYMENTERROR",
                                    "zpTransToken" to zpTransToken,
                                    "appTransID" to appTransID
                                ))
                            }

                            override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                                _eventSink?.success(mapOf(
                                    "errorCode" to "PAYMENTCOMPLETE",
                                    "zpTransToken" to transToken,
                                    "transactionId" to transactionId,
                                    "appTransID" to appTransID
                                ))
                            }
                        })
                    } ?: run {
                        result.success("Token is null")
                    }
                } else {
                    result.success("Method Not Implemented")
                }
            }
    }
}
