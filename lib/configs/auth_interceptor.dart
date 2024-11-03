import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    log('token: $token');
    log('Request Headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response Status Code: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      log('Token expired, trying to refresh token...');
    }
    super.onError(err, handler);
  }
}

Future<String?> _getAccessToken() async {
  final sf = await SharedPreferences.getInstance();
  var accessToken = sf.getString(AuthDataConstants.accessToken);
  return accessToken;
}
