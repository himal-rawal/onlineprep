import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginChecker extends ChangeNotifier {
  String? _value;
  String get value => _value ?? '';

  /// Checks token in storage
  Future<bool> checkToken() async {
    const storage = FlutterSecureStorage();
    _value = await storage.read(key: 'token');
    if (_value == null) {
      return false;
    } else {
      return true;
    }
  }
}
