import 'package:flutter/material.dart';

import '../modal/score_ranking.dart';
import '../repositories/test_history.dart';

class ScoreHistoryViewModel extends ChangeNotifier {
  Future<List<ScoreData>> getScoreHistory(String userId) async {
    final response = await TestHistory().getLoggedInUserScoreHistory(userId);
    return response.data ?? [];
  }
}
