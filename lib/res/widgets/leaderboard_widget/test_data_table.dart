import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/score_viewmodel.dart';

class SimpleDataTable extends StatelessWidget {
  const SimpleDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<ScoreViewModel>().getRankingScore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          final rankingScore = snapshot.data;
          if (rankingScore == null) {
            return Text("returned null data");
          } else if (rankingScore.isEmpty) {
            return Center(child: Text("No one has given this test"));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  // Datatable widget that have the property columns and rows.
                  columns: const [
                    // Set the name of the column
                    DataColumn(
                      label: Text(
                        'Rank',
                        style: TextStyle(color: Color(0xff03dac6)),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(color: Color(0xff03dac6)),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        'Marks',
                        style: TextStyle(color: Color(0xff03dac6)),
                      ),
                    ),
                  ],
                  rows: rankingScore
                      .map(((element) => DataRow(cells: <DataCell>[
                            DataCell(Text((rankingScore.indexOf(element) + 1)
                                .toString())),
                            DataCell(SizedBox(
                              child: Text(
                                element.username ?? "",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                              ),
                            )),
                            DataCell(Text(element.score ?? "")),
                          ])))
                      .toList()),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
    // MaterialApp with debugShowCheckedModeBanner false and home

    // Scaffold with appbar ans body.
  }
}
