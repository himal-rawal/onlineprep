import '../data/app_exceptions.dart';
import '../data/network/baseapi_services.dart';
import '../data/network/network_api_services.dart';
import '../modal/question_categories.dart';
import '../res/app_url.dart';

class QuestionCategoriesProvider {
  static final BaseApiServices _apiServices = NetworkApiServices();

  static Future<QuestionCategories> getQuestionCategories() async {
    try {
      final reponse = await _apiServices.getGetApiResponse(
        AppUrl.questionCategoriesUrl,
      );
      QuestionCategories questionCategoriesModal =
          questioncategoryModelFromJson(reponse);
      return questionCategoriesModal;
    } catch (e) {
      throw FetchDataException('.');
    }
  }
}
