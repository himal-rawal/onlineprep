import 'package:flutter/material.dart';

class SimpleDataTable extends StatelessWidget {
  const SimpleDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp with debugShowCheckedModeBanner false and home

        // Scaffold with appbar ans body.

        SingleChildScrollView(
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
                'Category',
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
          rows: const [
            // Set the values to the columns
            DataRow(cells: [
              DataCell(Text("1")),
              DataCell(Text("Alex")),
              DataCell(Text("Biology")),
              DataCell(Text("18")),
            ]),
            DataRow(cells: [
              DataCell(Text("2")),
              DataCell(Text("John")),
              DataCell(Text("Biology")),
              DataCell(Text("24")),
            ]),
          ]),
    );
  }
}
