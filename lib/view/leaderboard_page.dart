import 'package:flutter/material.dart';

import '../res/widgets/leaderboard_widget/test_data_table.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          const SliverToBoxAdapter(
            child: SimpleDataTable(),
          )
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
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
      collapsedHeight: 60,
    );
  }
}
