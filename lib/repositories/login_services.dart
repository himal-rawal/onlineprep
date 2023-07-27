import 'dart:convert';

import 'package:onlineprep/data/app_exceptions.dart';
import 'package:onlineprep/data/network/baseapi_services.dart';
import 'package:onlineprep/data/network/network_api_services.dart';
import 'package:onlineprep/res/app_url.dart';

import '../modal/users.dart';

class LoginServices {
  static final BaseApiServices _apiServices = NetworkApiServices();
  Future<UserModelResponse> userLogin(dynamic data) async {
    try {
      final response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      UserModelResponse userJwtToken =
          UserModelResponse.fromJson(json.decode(response));
      return userJwtToken;
    } catch (e) {
      throw FetchDataException();
    }
  }
}
