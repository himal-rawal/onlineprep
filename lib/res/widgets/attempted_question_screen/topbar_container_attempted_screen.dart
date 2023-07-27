import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/question_view_model.dart';
import '../../../viewmodel/timer_provider.dart';

class TopBarContainerForAttemptedScreen extends StatelessWidget {
  const TopBarContainerForAttemptedScreen({
    super.key,
  });

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
            //mainAxisAlignment: MainAxisAlignment.,
            children: [
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.navigate_before,
                      color: Colors.white, size: 30)),
              const SizedBox(width: 10),
              Container(
                  padding: const EdgeInsets.all(8),
                  width: 80,
                  decoration: _boxDecoration(),
                  child: Consumer<TimerInfoProvider>(
                    builder: (context, value, child) {
                      return Text(
                        "${value.hours}:${value.minutes}:${value.seconds}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      );
                    },
                  )),
              const SizedBox(
                width: 20,
              ),
              _attemptedQuestionNoText(context),
            ],
          ),
        ],
      ),
    );
  }

  Text _attemptedQuestionNoText(BuildContext context) {
    return Text(
      "${context.watch<QuestionViewModel>().attemptedQuestionsIndex.length.toString()} question attempted", //
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent);
  }
}
