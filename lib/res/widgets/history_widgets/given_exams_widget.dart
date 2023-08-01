import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modal/score_ranking.dart';
import '../../../viewmodel/score_history_viewmodel.dart';
import '../../../viewmodel/user_data_viewmodel.dart';

class GivenExams extends StatelessWidget {
  const GivenExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: context
                .read<ScoreHistoryViewModel>()
                .getScoreHistory(context.read<UserDataViewModel>().userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                final scoreHistoryData = snapshot.data;
                if (scoreHistoryData == null) {
                  return Text("Got Null Data Fro Server");
                } else if (scoreHistoryData.isEmpty) {
                  return Center(child: Text("You Havent given any Test"));
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor: const Color(0xFF494949),
                            // leading: const CircleAvatar(
                            //     backgroundImage: NetworkImage(
                            //         'https://www.cedars-sinai.org/content/dam/cedars-sinai/blog/2020/06/viruses-bacteria-fungi.jpg')),
                            title: Text(
                                scoreHistoryData[index].categoryname ?? ""),
                            subtitle: Text(
                                '${scoreHistoryData[index].createdAt ?? ""} at ${scoreHistoryData[index].createdAtTime}'),
                            trailing: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red.shade300,
                              child: Text(
                                scoreHistoryData[index].score ?? "",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: scoreHistoryData.length);
                }
              }
              return CircularProgressIndicator();
            }));
  }
}
