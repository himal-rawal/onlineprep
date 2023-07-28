import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onlineprep/data/app_exceptions.dart';
import 'package:onlineprep/data/network/baseapi_services.dart';

import 'dio_interceptor.dart';

class NetworkApiServices extends BaseApiServices {
  Future<String> getAcessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> deleteExpiredAcessToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  @override
  Future getGetApiResponse(String url) async {
    final dio = Dio();
    dynamic responseJson;
    try {
      String getToken = await getAcessToken();
      //     Dio addInterceptors(Dio dio) {
      // dio.interceptors.add(DioInterceptor());
//}

      dio.interceptors.add(DioInterceptor());

      final response = await dio.get(url).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    final dio = Dio();
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

  @override
  Future getPostApiResponseWithToken(String url, dynamic data) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet COnnection ");
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
