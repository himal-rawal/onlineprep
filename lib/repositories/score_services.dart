import 'dart:convert';

import 'package:onlineprep/data/app_exceptions.dart';
import 'package:onlineprep/data/network/baseapi_services.dart';
import 'package:onlineprep/data/network/network_api_services.dart';
import 'package:onlineprep/res/app_url.dart';

import '../modal/scores.dart';

class ScoreServices {
  static final BaseApiServices _apiServices = NetworkApiServices();

  Future<PostScoreResponse> setScoreToDatabase(dynamic data) async {
    try {
      final response =
          await _apiServices.getPostApiResponseWithToken(AppUrl.score, data);
      PostScoreResponse scoreService =
          PostScoreResponse.fromJson(json.decode(response));
      return scoreService;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
