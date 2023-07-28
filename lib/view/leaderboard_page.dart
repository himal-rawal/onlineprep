import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/widgets/leaderboard_widget/test_data_table.dart';
import '../viewmodel/question_categories_viewmodel.dart';
import '../viewmodel/score_viewmodel.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(30),
              child: DropdownButton<String>(
                //dropdownColor: const Color.fromARGB(255, 87, 172, 242),
                value: context.watch<ScoreViewModel>().selectedDropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.white,
                ),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                onChanged: (String? newValue) {
                  context
                      .read<ScoreViewModel>()
                      .setSelectedDropDownValue(newValue ?? '');
                },
                items: context
                    .read<QuestionCategoriesViewModeel>()
                    .nameOfCategories
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      softWrap: false,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SimpleDataTable(),
          )
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar(BuildContext context) {
    return const SliverAppBar(
      title: Text(
        "Ranking",
        style: TextStyle(
          color: Color(0xff03dac6),
        ),
      ),
      centerTitle: false,
      floating: true,
      flexibleSpace: SizedBox(),
      expandedHeight: 80,
      collapsedHeight: 65,
    );
  }
}
