import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DioInterceptor extends Interceptor {
  Future<String> getAcessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> deleteExpiredAcessToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String getToken = await getAcessToken();
    options.headers['Authorization'] = 'Bearer $getToken';
    super.onRequest(options, handler);
    return options;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String getToken = await getAcessToken();
    if (err.response?.statusCode == 401) {
      // If a 401 response is received, check whether the token is expired or not
      bool hasExpired = JwtDecoder.isExpired(getToken);
      if (hasExpired) {
        deleteExpiredAcessToken();
      }

      return handler.reject(err);
    }

    super.onError(err, handler);
    return handler.next(err);
  }
}
