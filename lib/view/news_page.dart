import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: SizedBox(),
          expandedHeight: 80,
          collapsedHeight: 60,
          title: Text(
            "News And Announcements",
            style: TextStyle(color: Color(0xff03dac6)),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 10, (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF494949)),
            );
          })),
        )
      ],
    ));
  }
}
