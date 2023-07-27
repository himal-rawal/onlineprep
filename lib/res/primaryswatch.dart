import 'package:flutter/material.dart';

MaterialColor createPrimaryMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int primaryColor = color.value;

  for (int i = 0; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    swatch[(strength * 1000).round()] =
        Color(primaryColor).withOpacity(1.0 - strength);
  }

  return MaterialColor(primaryColor, swatch);
}
