import 'package:flutter/material.dart';

class AvailableExams extends StatelessWidget {
  const AvailableExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(child: Text("No Exams Available")),
      ),
    );
  }
}
