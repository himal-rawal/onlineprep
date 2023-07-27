import 'dart:async';
import 'package:flutter/material.dart';

class TimerInfoProvider with ChangeNotifier {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  Timer? _timer;

  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else {
        _seconds = 0;
        if (_minutes < 59) {
          _minutes++;
        } else {
          _minutes = 0;
          _hours++;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    notifyListeners();
  }
}
