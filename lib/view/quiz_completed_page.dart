import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/question_view_model.dart';

class QuizCompletedPage extends StatelessWidget {
  final String? categoryName;
  const QuizCompletedPage({this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    String wrongAnswers =
        context.read<QuestionViewModel>().setWrongAnswers().toString();
    String totalQuestions =
        context.read<QuestionViewModel>().allResult.length.toString();
    String correctAnswer =
        context.read<QuestionViewModel>().correctAnswers.toString();

    return WillPopScope(
      onWillPop: () async {
        context.read<QuestionViewModel>().clearStates();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          _showScoreAndCategory(context),
          _displayStatisctics(
              context, totalQuestions, correctAnswer, wrongAnswers),
          _buildQuestionAnswerList(context)
        ],
      )),
    );
  }

  SliverToBoxAdapter _showScoreAndCategory(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: 15,
            right: 15),
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _clearIcon(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  _displayScoreContainer(context),
                  const SizedBox(width: 15),
                  _displayCategoryName()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SliverList _buildQuestionAnswerList(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: context.read<QuestionViewModel>().allResult.length,
            (context, index) {
      return ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${index + 1}. ${context.read<QuestionViewModel>().allResult[index].question}",
                maxLines: 3,
              ),
            ),
            context
                    .read<QuestionViewModel>()
                    .correctAnswerList
                    .contains(index + 1)
                ? const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.clear_rounded,
                    color: Colors.red,
                  ),
          ],
        ),
        subtitle: Text(
          context.read<QuestionViewModel>().allResult[index].answer ?? "",
          style: const TextStyle(color: Color(0xff03dac6)),
        ),
      );
    }));
  }

  SliverToBoxAdapter _displayStatisctics(BuildContext context,
      String totalQuestions, String correctAnswer, String wrongAnswers) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF494949)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _marksStatistics("Total Marks", totalQuestions),
            _whiteVerticalLine(context),
            _marksStatistics("Correct", correctAnswer),
            _whiteVerticalLine(context),
            _marksStatistics("Wrong", wrongAnswers),
          ],
        ),
      ),
    );
  }

  Expanded _displayCategoryName() {
    return Expanded(
      child: Column(
        children: [
          Text(
            categoryName ?? '',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
          )
        ],
      ),
    );
  }

  Container _displayScoreContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.29,
      width: MediaQuery.of(context).size.width * 0.29,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff03dac6)),
      child: Center(
        child: Text(
          context.read<QuestionViewModel>().correctAnswers.toString(),
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  GestureDetector _clearIcon(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<QuestionViewModel>().clearStates();
          Navigator.pop(context);
        },
        child: const Icon(Icons.clear, size: 30));
  }

  Container _whiteVerticalLine(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: 1,
      color: Colors.white,
    );
  }

  Column _marksStatistics(String heading, String trailing) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          trailing,
          style: const TextStyle(fontSize: 15, color: Color(0xff03dac6)),
        ),
      ],
    );
  }
}

// Future<bool?> _showDialogBoxOnBackButtonPressed(
//     BuildContext context, QuestionViewModel questionViewModel) {
//   return showDialog<bool>(
//     context: context,
//     builder: (context) {
      
      
//       // return AlertDialog(
//       //   title: const Text('Do you want to exit quiz ?'),
//       //   actionsAlignment: MainAxisAlignment.spaceBetween,
//       //   actions: [
//       //     TextButton(
//       //       onPressed: () {
//       //         Navigator.pop(context, true);
//       //         questionViewModel.clearStates();
//       //       },
//       //       child: const Text('Yes'),
//       //     ),
//       //     TextButton(
//       //       onPressed: () {
//       //         Navigator.pop(context, false);
//       //       },
//       //       child: const Text("Nah I will continue"),
//       //     ),
//       //   ],
//       // );
//     },
//   );
//}
// Stack(fit: StackFit.expand, children: [
//         Container(
//           padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height * 0.06,
//               left: 15,
//               right: 15),
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.black12,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Icons.clear, size: 30),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.width * 0.29,
//                       width: MediaQuery.of(context).size.width * 0.29,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xff03dac6)),
//                       child: Center(
//                         child: Text(
//                           "88",
//                           style: TextStyle(
//                               fontSize: 40, fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             "Common Entrance Exam (CEE) Medical",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w800, fontSize: 25),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: MediaQuery.of(context).size.height * 0.4,
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             color: Color(0xFF494949),
//           ),
//         )
//       ]),