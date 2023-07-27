import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repositories/login_services.dart';
import '../repositories/signup_services.dart';

/// All Authentication Related ViewLogics
class AuthViewModel extends ChangeNotifier {
  String? _token;
  String get token => _token ?? '';
  // bool? _sucess;
  // bool get sucess => _sucess ?? false;
  // void setSucess(bool success) {
  //   _sucess = null;
  // }

  final storage = const FlutterSecureStorage();

  /// Login Function
  Future<bool> getLoginToken(String email, String password) async {
    try {
      Map data = {'auth': email, 'password': password};
      final response = await LoginServices().userLogin(data);
      _token = response.token;
      await storage.write(key: "token", value: _token);
      //print(response.sucess);
      //print(response.token);
      // _sucess = response.sucess;
      return response.sucess ?? false;
    } catch (e) {
      //_error = 'incorrect username or password';
      return false;
    }
  }

  /// LogOut Function
  void logOut() {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'token');
  }

  /// SignUp Function
  Future<bool?> signUp(Map data) async {
    try {
      final response = await SignUpServices().userSignUp(data);
      //print(response.sucess);
      return response.sucess ?? false;
    } catch (e) {
      return null;
    }
  }
}
