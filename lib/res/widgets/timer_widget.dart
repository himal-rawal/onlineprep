import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/timer_provider.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    context.read<TimerInfoProvider>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerInfoProvider>(
      builder: (context, value, child) {
        return Text(
          "${value.hours}:${value.minutes}:${value.seconds}",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        );
      },
    );
  }
}
