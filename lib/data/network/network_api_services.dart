import 'dart:convert';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onlineprep/data/app_exceptions.dart';
import 'package:onlineprep/data/network/baseapi_services.dart';

class NetworkApiServices extends BaseApiServices {
  Future<String> getAcessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> deleteExpiredAcessToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  static final dio = Dio();
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      String getToken = await getAcessToken();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Add the access token to the request header
            options.headers['Authorization'] = 'Bearer $getToken';
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              bool hasExpired = JwtDecoder.isExpired(getToken);
              if (hasExpired) {
                deleteExpiredAcessToken();
              }

              // Update the request header with the new access token
              // e.requestOptions.headers['Authorization'] =
              //     'Bearer $newAccessToken';

              // Repeat the request with the updated header //dio.fetch(e.requestOptions)
              return handler.reject(e);
            }
            return handler.next(e);
          },
        ),
      );

      final response = await dio.get(url).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
    return responseJson;
  }

  /// We handled all response cases here in this function.
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonEncode(response.data);
        return responseJson;

      case 400:
        throw BadRequestException(response.statusCode.toString());

      case 404:
        throw BadRequestException(response.statusCode.toString());

      default:
        throw FetchDataException(
            'Error occured while communicating with server with status code${response.statusCode}');
    }
  }
}
