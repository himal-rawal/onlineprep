import 'package:flutter/material.dart';
import 'package:onlineprep/view/login_page.dart';
import 'package:provider/provider.dart';

import '../res/widgets/bottom_nav_bar_widget.dart';
import '../viewmodel/checklogeedin.dart';
import '../viewmodel/user_data_viewmodel.dart';

/// This will Continiously Listen to Auth State Change and return
/// accordingly.
class SignInDetector extends StatelessWidget {
  const SignInDetector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<LoginChecker>().checkToken(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text("Something went wrong");
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  context.read<UserDataViewModel>().userId.isEmpty
                      ? context.read<UserDataViewModel>().getUserdata()
                      : null;
                  //print(snapshot.data);
                  return ButtonNavBarRoutes();
                } else {
                  return const LoginPage();
                }
              }
            }
            return const LoginPage();
          })),
    );
  }
}
