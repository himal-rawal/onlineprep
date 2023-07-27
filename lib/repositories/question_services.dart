import 'package:dio/dio.dart';

import '../data/network/baseapi_services.dart';
import '../data/network/network_api_services.dart';
import '../modal/questions.dart';
import '../res/app_url.dart';

class QuestionService {
  static final dio = Dio();

  static final BaseApiServices _apiServices = NetworkApiServices();

  Future<QuestionModel> getQuestionModel(String getCategory) async {
    try {
      final response = await _apiServices
          .getGetApiResponse(AppUrl().questionUrlMethod(getCategory));
      QuestionModel questionModel = questionModelFromJson(response);
      return questionModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
