import 'dart:convert';
import 'package:onlineprep/data/network/baseapi_services.dart';
import 'package:onlineprep/data/network/network_api_services.dart';
import 'package:onlineprep/res/app_url.dart';

import '../modal/users.dart';

class UserServices {
  static final BaseApiServices _apiServices = NetworkApiServices();
  Future<UserModel> userLogin() async {
    try {
      final response = await _apiServices.getGetApiResponse(AppUrl.userdata);
      UserModel userdata = UserModel.fromJson(json.decode(response));
      return userdata;
    } catch (e) {
      rethrow;
    }
  }
}
