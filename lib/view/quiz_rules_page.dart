import 'package:flutter/material.dart';
import 'package:onlineprep/view/quiz_page.dart';

class QuizRulesPage extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;
  const QuizRulesPage({this.categoryId, this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    //print(categoryName);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                Text(
                    "Dear Himani ,\n\nAs you prepare for the exam, we want to ensure a fair and secure testing environment for all participants."),
                Text(
                    "Please take a moment to carefully read and understand the following rules and guidelines that must be followed during the exam:\n"),
                Text(
                    "1. Exam Time and Access:\n- The duration of the exam is 2 hours, and the timer will start automatically once you begin.\n"),
                Text(
                    "2. Exam Environment:\n- Find a quiet and distraction-free environment to take the exam.\n- Make sure your computer or device is charged and that you have a stable internet connection.\n"),
                Text(
                    "- Once you start the exam, do not leave the exam environment until you have completed the test and submitted your answers.\n\n- Ensure you complete and submit the exam within the allotted time. The exam will be automatically submitted once the time limit expires.\n"),
              ],
            ),
            GestureDetector(
              onTap: () => _navigateToQuizPageScreen(context),
              child: _startExamButton(context),
            )
          ],
        ),
      ),
    );
  }

  Container _startExamButton(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFF969798)),
      child: const Center(
        child: Text(
          "START EXAM",
          style: TextStyle(
              color: Color(0xff03dac6),
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
    );
  }

  void _navigateToQuizPageScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => QuizScreenPage(
              category: categoryId,
              categoryname: categoryName,
            )));
  }
}
