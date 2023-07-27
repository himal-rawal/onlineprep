import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onlineprep/res/primaryswatch.dart';
import 'package:onlineprep/view/signin_detector.dart';
import 'package:onlineprep/viewmodel/bottom_nav_bar.dart';
import 'package:onlineprep/viewmodel/checklogeedin.dart';
import 'package:onlineprep/viewmodel/auth_viewmodel.dart';
import 'package:onlineprep/viewmodel/question_categories_viewmodel.dart';
import 'package:onlineprep/viewmodel/question_view_model.dart';
import 'package:onlineprep/viewmodel/timer_provider.dart';
import 'package:onlineprep/viewmodel/user_data_viewmodel.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationBarProvider>(
              create: (_) => BottomNavigationBarProvider()),
          ChangeNotifierProvider<TimerInfoProvider>(
              create: (_) => TimerInfoProvider()),
          ChangeNotifierProvider<QuestionCategoriesViewModeel>(
              create: (_) => QuestionCategoriesViewModeel()),
          ChangeNotifierProvider<QuestionViewModel>(
              create: (_) => QuestionViewModel()),
          ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
          ChangeNotifierProvider<LoginChecker>(create: (_) => LoginChecker()),
          ChangeNotifierProvider<UserDataViewModel>(
              create: (_) => UserDataViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(primary: Color(0xff03dac6)),
            primarySwatch: createPrimaryMaterialColor(const Color(0xFF494949)),
          ),
          home: const SignInDetector(),
        ));
  }
}
