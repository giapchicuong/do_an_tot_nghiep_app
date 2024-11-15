import 'dart:async';

import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/create_order_response.dart';
import '../utils/util.dart' as utils;

class ZaloPayConfig {
  static const String appId = "2554";
  static const String key1 = "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn";
  static const String key2 = "trMrHtvjo6myautxDUiAcYsVtaeQ8nhf";

  static const String appUser = "zalopaydemo";
  static int transIdDefault = 1;
}

Future<CreateOrderResponse?> createOrder(int price) async {
  var header = new Map<String, String>();
  header["Content-Type"] = "application/x-www-form-urlencoded";

  var body = new Map<String, String>();
  body["app_id"] = ZaloPayConfig.appId;
  body["app_user"] = ZaloPayConfig.appUser;
  body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
  body["amount"] = price.toStringAsFixed(0);
  body["app_trans_id"] = utils.getAppTransId();
  body["embed_data"] = "{}";
  body["item"] = "[]";
  body["bank_code"] = utils.getBankCode();
  body["description"] = utils.getDescription(body["app_trans_id"]!);

  var dataGetMac = sprintf("%s|%s|%s|%s|%s|%s|%s", [
    body["app_id"],
    body["app_trans_id"],
    body["app_user"],
    body["amount"],
    body["app_time"],
    body["embed_data"],
    body["item"]
  ]);
  body["mac"] = utils.getMacCreateOrder(dataGetMac);
  print("mac: ${body["mac"]}");
  print(dataGetMac);
  //
  // http.Response response = await http.post(
  //   Uri.parse(Endpoints.createOrderUrl),
  //   headers: header,
  //   body: body,
  // );
  //
  // print("body_request: $body");
  // if (response.statusCode != 200) {
  //   return null;
  // }
  //
  // var data = jsonDecode(response.body);
  // final orderUrl = data['order_url'];
  // print("data_response: $data}");
  // print(orderUrl);
  // await _launchUrl(
  //     'https://qcgateway.zalopay.vn/openinapp?order=eyJ6cHRyYW5zdG9rZW4iOiJBQ09OMjlzZ1dtU1dfQXlQa09DODFJblEiLCJhcHBpZCI6MjU1NH0=');
  await _launchUrl(
      'https://qcgateway.zalopay.vn/openinapp?order=eyJ6cHRyYW5zdG9rZW4iOiJBQ1Y0dVZiSU1odzdpZGViLThaY3p5N1EiLCJhcHBpZCI6MjU1NH0=');
  // return CreateOrderResponse.fromJson(data);
}

Future<void> _launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    print("Không thể mở URL: $url");
  }
}
