import 'package:onlineprep/data/network/baseapi_services.dart';
import 'package:onlineprep/data/network/network_api_services.dart';
import 'package:onlineprep/res/app_url.dart';

import '../modal/score_ranking.dart';

class TestHistory {
  static final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<RankingScore> getLoggedInUserScoreHistory(String userId) async {
    final response =
        await _baseApiServices.getGetApiResponse(AppUrl().scoreHistory(userId));
    RankingScore getScoreHistory = rankingModelFromJson(response);
    return getScoreHistory;
  }
}
