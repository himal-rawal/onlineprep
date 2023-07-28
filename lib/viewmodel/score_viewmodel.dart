import 'package:flutter/material.dart';
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
  String get selectedDropdownValue => _selectedDropdownValue ?? 'Aptitude';

  /// Setting DropDown Value when clicked on dropdown list
  void setSelectedDropDownValue(String dropDownValue) {
    _selectedDropdownValue = dropDownValue;
    notifyListeners();
  }
}
