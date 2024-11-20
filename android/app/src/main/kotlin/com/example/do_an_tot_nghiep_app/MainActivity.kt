package com.example.do_an_tot_nghiep_app

import android.app.AlertDialog
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import vn.zalopay.sdk.Environment
import vn.zalopay.sdk.ZaloPayError
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener

class MainActivity: FlutterActivity() {
    private val eventChannel = "flutter.native/eventPayOrder"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ZaloPaySDK.init(2554, Environment.SANDBOX) // Merchant AppID
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("newIntent", intent.toString())
        ZaloPaySDK.getInstance().onResult(intent)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val channelPayOrder = "flutter.native/channelPayOrder"
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelPayOrder)
            .setMethodCallHandler { call, result ->
                if (call.method == "payOrder") {
                    val tagSuccess = "[OnPaymentSucceeded]"
                    val tagError = "[onPaymentError]"
                    val tagCanel = "[onPaymentCancel]"
                    val token = call.argument<String>("zptoken")

                    ZaloPaySDK.getInstance().payOrder(
                        this@MainActivity,
                        token !!,
                        "demozpdk://app",
                        object : PayOrderListener {
                            override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                                Log.d(tagCanel, String.format("[TransactionId]: %s, [appTransID]: %s", zpTransToken, appTransID))
                                result.success("User Canceled")
                                sendEventToFlutter("User Canceled", 4)
                            }

                            override fun onPaymentError(
                                zaloPayErrorCode: ZaloPayError?,
                                zpTransToken: String?,
                                appTransID: String?
                            ) {
                                // Null checks to avoid the Parcel error
                                if (zpTransToken == null || appTransID == null) {
                                    Log.e(tagError, "Transaction or AppTransID is null")
                                    result.success("Payment failed")
                                    sendEventToFlutter("Payment failed", 3)
                                } else {
                                    Log.d(tagError, String.format("[zaloPayErrorCode]: %s, [zpTransToken]: %s, [appTransID]: %s", zaloPayErrorCode.toString(), zpTransToken, appTransID))
                                    result.success("Payment failed")
                                    sendEventToFlutter("Payment failed", 3)
                                }
                            }


                            override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                                Log.d(tagSuccess, String.format("[TransactionId]: %s, [TransToken]: %s, [appTransID]: %s", transactionId, transToken, appTransID))
                                result.success("Payment Success")
                                sendEventToFlutter("Payment Success", 1)
                            }
                        })
                } else {
                    Log.d("[METHOD CALLER] ", "Method Not Implemented")
                    result.success("Payment failed")
                }
            }

        // Event Channel to send events to Flutter
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannel)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    // Handle the event stream; send events to Flutter
                    events?.success("EventChannel Initialized") // You can send any initialization event here.
                }

                override fun onCancel(arguments: Any?) {
                    // Handle cancellation of the event stream
                }
            })
    }

    private fun sendEventToFlutter(message: String, errorCode: Int) {
        val event = HashMap<String, Any>()
        event["message"] = message
        event["errorCode"] = errorCode

        // Check if flutterEngine is not null
        flutterEngine?.let {
            val channel = EventChannel(it.dartExecutor.binaryMessenger, eventChannel)
            channel.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    events?.success(event) // Send the event data to Flutter side
                }

                override fun onCancel(arguments: Any?) {
                    // Handle cancellation of event stream
                }
            })
        } ?: run {
            Log.e("EventChannel", "Flutter engine is null")
        }
    }
}
