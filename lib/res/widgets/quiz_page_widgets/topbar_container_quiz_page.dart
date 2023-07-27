import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modal/questions.dart';
import '../../../view/attempted_question_page.dart';
import '../../../viewmodel/question_view_model.dart';
import '../timer_widget.dart';

class TopBarContainer extends StatelessWidget {
  const TopBarContainer(
      {super.key,
      required this.data,
      this.categoryName,
      required this.category});

  final List<Result> data;
  final String category;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06, left: 15, right: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timerScreenContainer(),
              _questionNumberDisplay(),
              _attemptedQuestionScreenNavigator(context)
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector _attemptedQuestionScreenNavigator(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuestionAtemptedScreen(
              noOfQuestions: data.length,
              categoryId: category,
              categoryName: categoryName))),
      child: const Icon(
        Icons.apps,
        color: Colors.white,
      ),
    );
  }

  Consumer<QuestionViewModel> _questionNumberDisplay() {
    return Consumer<QuestionViewModel>(
      builder: (context, value, child) {
        //value.addOptionsToList(data ?? [], value.counter);
        //value.addTraversedQuestionToList(value.counter);
        return Text(
          "Q. ${value.counter + 1}",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        );
      },
    );
  }

  Container _timerScreenContainer() {
    return Container(
        padding: const EdgeInsets.all(8),
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent),
        child: const TimerScreen());
  }
}
