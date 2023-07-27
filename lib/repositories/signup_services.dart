import 'dart:convert';

import 'package:onlineprep/data/app_exceptions.dart';
import 'package:onlineprep/data/network/baseapi_services.dart';
import 'package:onlineprep/data/network/network_api_services.dart';
import 'package:onlineprep/res/app_url.dart';

import '../modal/users.dart';

class SignUpServices {
  static final BaseApiServices _apiServices = NetworkApiServices();
  Future<UserModelResponse> userSignUp(dynamic data) async {
    try {
      final response =
          await _apiServices.getPostApiResponse(AppUrl.signUP, data);
      UserModelResponse userJwtToken =
          UserModelResponse.fromJson(json.decode(response));
      return userJwtToken;
    } catch (e) {
      throw FetchDataException();
    }
  }
}
