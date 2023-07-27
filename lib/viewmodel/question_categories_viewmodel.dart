import 'package:flutter/widgets.dart';

import '../modal/question_categories.dart';
import '../repositories/question_categories_services.dart';

/// Class To Fetch  Categories
class QuestionCategoriesViewModeel with ChangeNotifier {
  List<Categories> _allCategories = [];
  //List nameOfCategories = [];
  List<Categories> get allCategories => _allCategories;
  Future<List<Categories>> getAllCategories() async {
    try {
      final response = await QuestionCategoriesProvider.getQuestionCategories();
      _allCategories = response.categories ?? [];
      //Storing name of categories in List to use in DropDown Menu
      // for (int i = 0; i < _allCategories.length; i++) {
      //    if (!nameOfCategories.contains(_allCategories[i].title)) {
      //      nameOfCategories.add(_allCategories[i].title);
      //    }
      // }
    } catch (e) {
      rethrow;
    }
    return _allCategories;
  }
}
