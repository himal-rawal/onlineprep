import 'package:flutter/material.dart';

import '../repositories/user_services.dart';

class UserDataViewModel extends ChangeNotifier {
  String? _name;
  String get name => _name ?? '';
  String? _role;
  String get role => _role ?? '';
  String? _userId;
  String get userId => _userId ?? '';
  Future<void> getUserdata() async {
    final response = await UserServices().userLogin();

    _name = response.data?.username;
    _role = response.data?.role;
    _userId = response.data?.id;
    notifyListeners();
  }

  void clearDetails() {
    _name = null;
    _role = null;
    _userId = null;
  }
}
