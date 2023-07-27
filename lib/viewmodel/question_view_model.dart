import 'package:flutter/foundation.dart';

import '../modal/questions.dart';
import '../repositories/question_services.dart';

class QuestionViewModel with ChangeNotifier {
  List<Result> _allResults = [];
  List<Result> get allResult => _allResults;

  /// Function to get all Questions Of given Category
  Future<List<Result>> getAllQuestions(String getCategory) async {
    try {
      final response = await QuestionService().getQuestionModel(getCategory);

      _allResults = response.results ?? [];
    } catch (e) {
      if (kDebugMode) {
        print(e);
        rethrow;
      }
    }

    return _allResults;
  }

  int _counter = 0;
  int get counter => _counter;

  /// Function To set  question index to tapped index in Question
  /// Attempted Page
  void setCounterOnRedirect(int questionNo) {
    _counter = questionNo;
    notifyListeners();
  }

  /// To get index of next Question
  void getNextQuestionIndex(List data) {
    if (_counter < data.length - 1) {
      _counter++;
      notifyListeners();
    }
  }

  /// To get index Of Previous Question
  void getPreviousQuestionIndex(List data) {
    if (_counter < data.length && _counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  int _correctAnswers = 0;
  int get correctAnswers => _correctAnswers;

  int? selectedContainerIndex;

  void setSelectedContainer(int index) {
    selectedContainerIndex = index;
    notifyListeners();
  }

  // Map to store key:Question_No and value: Option_Index
  // Inorder to show color of previous selected answer
  Map selectedQuestionAnswers = {};

  /// This is to show color of previous selected answer
  void storeSelectedQuestionAnswer(int? questionIndex, int? answerIndex) {
    if (answerIndex != null && questionIndex != null) {
      if (!selectedQuestionAnswers.containsKey(questionIndex)) {
        selectedQuestionAnswers[questionIndex] = answerIndex;
      } else if (selectedQuestionAnswers.containsKey(questionIndex)) {
        selectedQuestionAnswers[questionIndex] = answerIndex;
      }
    }
  }

  // Getter for selected answer which we will use to show color of selected
  // option
  String? _selectedAnswer;
  String get selectedAnswer => _selectedAnswer ?? '';

  /// This Function is used to set slected answer
  /// To Show color when option is selected
  void storeSelectedAnswer(
    String? selectedAnswer,
  ) {
    _selectedAnswer = selectedAnswer;

    notifyListeners();
  }

  final List _correctAnswersList = [];
  List get correctAnswerList => _correctAnswersList;
  List attemptedQuestionsIndex = [];

  /// Function To check whether the selected answer is correct or not
  void checkAnswer(String correctAnswer, int index) {
    if (selectedAnswer == correctAnswer &&
        !attemptedQuestionsIndex.contains(index)) {
      attemptedQuestionsIndex.add(index);
      correctAnswerList.add(index);
      _correctAnswers++;
      // print(correctAnswer + "," + selectedAnswer);
      //print(correctAnswerList);
    } else if (selectedAnswer == correctAnswer &&
        attemptedQuestionsIndex.contains(index)) {
      correctAnswerList.add(index);
      _correctAnswers++;
      //print(correctAnswer + "," + selectedAnswer);
    } else if (selectedAnswer != correctAnswer &&
        attemptedQuestionsIndex.contains(index)) {
      correctAnswerList.remove(index);
      _correctAnswers--;
      // print(correctAnswer + "," + selectedAnswer);
    } else if (selectedAnswer.isNotEmpty &&
        !attemptedQuestionsIndex.contains(index)) {
      attemptedQuestionsIndex.add(index);
      //print(correctAnswer + "," + selectedAnswer);
    }
    notifyListeners();
  }

  /// Function to clear all states after comppleting test
  void clearStates() {
    _correctAnswersList.clear();
    attemptedQuestionsIndex.clear();
    _correctAnswers = 0;
    _selectedAnswer = null;
    selectedQuestionAnswers.clear();
    _counter = 0;
    selectedContainerIndex = null;
  }

  /// ViewModel to calculate and return wrong answers
  int setWrongAnswers() {
    return allResult.length - correctAnswers;
  }
}
