import 'package:flutter/material.dart';
import 'package:onlineprep/viewmodel/question_categories_viewmodel.dart';
import '../modal/score_ranking.dart';
import '../repositories/score_services.dart';

class ScoreViewModel extends ChangeNotifier {
  bool? _isLoading;
  bool get isLoading => _isLoading ?? false;
  void setIsLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  Future<bool> setScore(Map data) async {
    try {
      final response = await ScoreServices().setScoreToDatabase(data);
      return response.success ?? false;
    } catch (e) {
      rethrow;
    }
  }

  String? _selectedDropdownValue;
  String get selectedDropdownValue =>
      _selectedDropdownValue ?? '64bc0977d2ac2f8d2cc7e6ac';

  /// Setting DropDown Value when clicked on dropdown list
  void setSelectedDropDownValue(String dropDownValue) {
    _selectedDropdownValue = dropDownValue;
    notifyListeners();
  }

  Future<List<ScoreData>> getRankingScore() async {
    try {
      final response =
          await ScoreServices().getRankingScore(selectedDropdownValue);
      return response.data ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
