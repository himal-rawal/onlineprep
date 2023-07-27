import 'package:flutter/material.dart';
import 'package:onlineprep/view/quiz_completed_page.dart';
import 'package:onlineprep/view/quiz_page.dart';
import 'package:provider/provider.dart';

import '../res/widgets/attempted_question_screen/topbar_container_attempted_screen.dart';
import '../viewmodel/question_view_model.dart';
import '../viewmodel/timer_provider.dart';

class QuestionAtemptedScreen extends StatelessWidget {
  final int noOfQuestions;
  final String categoryId;
  final String? categoryName;
  const QuestionAtemptedScreen(
      {required this.noOfQuestions,
      this.categoryName,
      required this.categoryId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const TopBarContainerForAttemptedScreen(),
          _remainingScreenPositionedStackGrid(context),
          _submitButtonPositionedOnStack(context)
        ],
      ),
    );
  }

  Positioned _remainingScreenPositionedStackGrid(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18,
      left: 10,
      right: 10,
      bottom: 20,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        height: MediaQuery.of(context).size.height * 0.77,
        width: MediaQuery.of(context).size.width,
        decoration: _setBoxDecoration(),
        child: _buildGridView(),
      ),
    );
  }

  BoxDecoration _setBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      color: Color(0xFF494949),
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: noOfQuestions <= 50 ? 7 : 10,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemCount: noOfQuestions,
      itemBuilder: (context, index) {
        return _onTappingShowAttemptedQuestionContainer(context, index);
      },
    );
  }

  GestureDetector _onTappingShowAttemptedQuestionContainer(
      BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        context.read<QuestionViewModel>().setCounterOnRedirect(index);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuizScreenPage(
                  category: categoryId,
                )));
      },
      child: _containerToShowAttemptedQuestion(context, index),
    );
  }

  Container _containerToShowAttemptedQuestion(BuildContext context, int index) {
    return Container(
      height: 10,
      width: 10,
      color: context
              .read<QuestionViewModel>()
              .attemptedQuestionsIndex
              .contains(index + 1)
          ? Colors.green.shade400
          : const Color.fromARGB(255, 94, 90, 90),
      child: Center(child: Text((index + 1).toString())),
    );
  }

  Positioned _submitButtonPositionedOnStack(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.width * 0.2,
        child: GestureDetector(
          onTap: () {
            context.read<TimerInfoProvider>().stopTimer();
            context.read<TimerInfoProvider>().resetTimer();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => QuizCompletedPage(
                      categoryName: categoryName,
                    )));
          },
          child: _submitButtonContainer(context),
        ));
  }

  Container _submitButtonContainer(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.green.shade600,
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.7,
      child: const Center(
          child: Text(
        "Submit",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }
}
