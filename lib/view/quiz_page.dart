import 'package:flutter/material.dart';
import 'package:onlineprep/view/quiz_completed_page.dart';
import 'package:onlineprep/viewmodel/timer_provider.dart';
import 'package:provider/provider.dart';
import '../modal/questions.dart';
import '../res/widgets/quiz_page_widgets/topbar_container_quiz_page.dart';
import '../viewmodel/question_view_model.dart';
import '../viewmodel/score_viewmodel.dart';
import '../viewmodel/user_data_viewmodel.dart';

class QuizScreenPage extends StatelessWidget {
  final String? category;
  final String? categoryname;

  const QuizScreenPage({this.category, this.categoryname, super.key});

  @override
  Widget build(BuildContext context) {
    QuestionViewModel questionViewModel = context.read<QuestionViewModel>();

    return Scaffold(
        body: FutureBuilder(
            future: questionViewModel.getAllQuestions(category ?? ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                if (data == null) {
                  return const Center(
                      child: Text("No Data Available Right Now"));
                }
                if (data.isEmpty) {
                  return const Center(child: Text("NO Questions to fetch "));
                } else {
                  return WillPopScope(
                    onWillPop: () async {
                      final shouldPop = await _showDialogBoxOnBackButtonPressed(
                          context, context.read<QuestionViewModel>());
                      return shouldPop!;
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        TopBarContainer(
                          data: data,
                          category: category ?? '',
                          categoryName: categoryname,
                        ),
                        _remainingScreenExceptTopBarContainer(
                            context, data, questionViewModel)
                      ],
                    ),
                  );
                }
              }
              return const CircularProgressIndicator();
            }));
  }

  Future<bool?> _showDialogBoxOnBackButtonPressed(
      BuildContext context, QuestionViewModel questionViewModel) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return _alertDialogBox(context, questionViewModel);
      },
    );
  }

  AlertDialog _alertDialogBox(
      BuildContext context, QuestionViewModel questionViewModel) {
    return AlertDialog(
      title: const Text('Do you want to exit quiz ?'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            questionViewModel.clearStates();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Nah I will continue"),
        ),
      ],
    );
  }

  Positioned _remainingScreenExceptTopBarContainer(BuildContext context,
      List<Result> data, QuestionViewModel questionViewModel) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18,
      left: 10,
      right: 10,
      child: _containerForQuizData(context, data, questionViewModel),
    );
  }

  Container _containerForQuizData(BuildContext context, List<Result> data,
      QuestionViewModel questionViewModel) {
    return Container(
      padding: const EdgeInsets.all(19),
      height: MediaQuery.of(context).size.height * 0.77,
      width: MediaQuery.of(context).size.width,
      decoration: _boxDecorationForRemainingScreenContainer(),
      child: Column(
        children: [
          _questionText(data),
          _buildOptions(data, context),
          _navigateButtons(questionViewModel, data, context),
        ],
      ),
    );
  }

  Row _navigateButtons(QuestionViewModel questionViewModel, List<Result> data,
      BuildContext context) {
    return Row(
      children: [
        questionViewModel.counter == 0
            ? const SizedBox()
            : _navigateBeforeIcon(questionViewModel, data, context),
        const SizedBox(width: 20),
        _nextQuestionButton(questionViewModel, data, context, categoryname)
      ],
    );
  }

  BoxDecoration _boxDecorationForRemainingScreenContainer() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      color: Color(0xFF494949),
    );
  }

  Expanded _nextQuestionButton(QuestionViewModel questionViewModel,
      List<Result> data, BuildContext context, categoryname) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          questionViewModel.getNextQuestionIndex(data);
          questionViewModel.selectedContainerIndex = null;
          questionViewModel.storeSelectedAnswer(null);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: context.watch<QuestionViewModel>().counter + 1 == data.length
                ? Colors.green.shade600 // Color(0xff03dac6)
                : const Color.fromARGB(
                    255, 4, 171, 154), // const Color.fromARGB(255, 94, 90, 90),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child:
                  context.watch<QuestionViewModel>().counter + 1 == data.length
                      ? _submitButton(context, categoryname, data)
                      : const Text("Next")),
        ),
      ),
    );
  }

  GestureDetector _submitButton(
      BuildContext context, String categoryname, List<Result> data) {
    return GestureDetector(
        onTap: () async {
          context.read<ScoreViewModel>().setIsLoading(true);
          //await Future.delayed(Duration(seconds: 10));
          Map data = {
            "score":
                context.read<QuestionViewModel>().correctAnswers.toString(),
            "category": category,
            "user": context.read<UserDataViewModel>().userId,
            "username": context.read<UserDataViewModel>().name,
            "categoryname": categoryname
          };

          bool setscoreSucess =
              await context.read<ScoreViewModel>().setScore(data);
          if (setscoreSucess && context.mounted) {
            context.read<TimerInfoProvider>().stopTimer();
            context.read<TimerInfoProvider>().resetTimer();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => QuizCompletedPage(
                      categoryName: categoryname,
                    )));
            context.read<ScoreViewModel>().setIsLoading(false);
          }
        },
        child: context.watch<ScoreViewModel>().isLoading
            ? const CircularProgressIndicator()
            : const Text(
                "Submit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ));
  }

  GestureDetector _navigateBeforeIcon(QuestionViewModel questionViewModel,
      List<Result> data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        questionViewModel.getPreviousQuestionIndex(data);
        questionViewModel.selectedContainerIndex = null;
        questionViewModel.storeSelectedAnswer(null);
      },
      child: _navigateBeforeIconContainer(),
    );
  }

  Container _navigateBeforeIconContainer() {
    return Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 171, 154),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.navigate_before),
    );
  }

  Expanded _buildOptions(List<Result> data, BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 11),
          itemCount:
              data[context.read<QuestionViewModel>().counter].options?.length ??
                  0,
          itemBuilder: (context, index) {
            return _onTapOptionContainer(index, data, context);
          }),
    );
  }

  GestureDetector _onTapOptionContainer(
      int index, List<Result> data, BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapOptions(context, index, data),
      child: _optionContainers(index, data),
    );
  }

  void _onTapOptions(BuildContext context, int index, List<Result> data) {
    context.read<QuestionViewModel>().setSelectedContainer(index);
    context.read<QuestionViewModel>().storeSelectedAnswer(
        data[context.read<QuestionViewModel>().counter].options![index]);
    context.read<QuestionViewModel>().storeSelectedQuestionAnswer(
        context.read<QuestionViewModel>().counter, index);
    context.read<QuestionViewModel>().checkAnswer(
        data[context.read<QuestionViewModel>().counter].answer ?? '',
        context.read<QuestionViewModel>().counter + 1);
  }

  Consumer<QuestionViewModel> _optionContainers(int index, List<Result> data) {
    return Consumer<QuestionViewModel>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minHeight: 40),
          decoration: _boxDecorationForOptionContainer(value, index),
          child: Center(
              child: Text(
            //value.option[index],
            data[value.counter].options?[index] ?? '',
            style: const TextStyle(
              fontSize: 17,
            ), //color: AppColors.optionsTextColor),
          )),
        );
      },
    );
  }

  BoxDecoration _boxDecorationForOptionContainer(
      QuestionViewModel value, int index) {
    return BoxDecoration(
      color: value.selectedContainerIndex == index
          ? Colors.green.shade300
          : value.selectedQuestionAnswers.containsKey(value.counter) &&
                  value.selectedQuestionAnswers[value.counter] == index
              ? Colors.green.shade300
              : const Color.fromARGB(255, 94, 90, 90),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Consumer<QuestionViewModel> _questionText(List<Result> data) {
    return Consumer<QuestionViewModel>(builder: (context, value, child) {
      return Text(
        data[value.counter].question ?? "",
        style: const TextStyle(fontSize: 18, color: Colors.white),
      );
    });
  }
}
