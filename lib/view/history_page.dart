import 'package:flutter/material.dart';

import '../res/widgets/history_widgets/available_exams_widget.dart';
import '../res/widgets/history_widgets/given_exams_widget.dart';

class QuizHistoryPage extends StatelessWidget {
  const QuizHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text(
                'Exams',
                style: TextStyle(color: Color(0xff03dac6)),
              ),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Creates border
                    color: const Color(0xff03dac6)),
                isScrollable: false,
                tabs: const [
                  Tab(child: Text('Available')),
                  Tab(child: Text('Given')),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            AvailableExams(),
            GivenExams(),
          ],
        ),
      )),
    );
  }
}
