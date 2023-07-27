import 'package:flutter/material.dart';
import 'package:onlineprep/view/history_page.dart';
import 'package:onlineprep/view/home_page.dart';
import 'package:onlineprep/view/leaderboard_page.dart';
import 'package:onlineprep/view/news_page.dart';
import 'package:onlineprep/viewmodel/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ButtonNavBarRoutes extends StatelessWidget {
  ButtonNavBarRoutes({super.key});

  /// List of Navbars pages
  final currentTab = [
    const HomepPage(),
    const QuizHistoryPage(),
    const LeaderBoardPage(),
    const NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider bottomnavProvider =
        context.read<BottomNavigationBarProvider>();

    return Scaffold(
      body:
          currentTab[context.watch<BottomNavigationBarProvider>().currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF494949),
        selectedItemColor: const Color(0xff03dac6),
        unselectedItemColor: Colors.white,
        enableFeedback: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: bottomnavProvider.currentIndex,
        onTap: (index) {
          bottomnavProvider.currentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Homepage"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_turned_in_outlined,
              ),
              label: "History"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard,
              ),
              label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "profile")
        ],
      ),
    );
  }
}
