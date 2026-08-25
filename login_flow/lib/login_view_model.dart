import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool isLoggedIn = false;

  Future<bool> isLoggedInToApp() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('loggedin');
  }

  setIsLoggedInToApp(bool value) async {
    isLoggedIn = value;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('loggedin', value).then((_) {
      notifyListeners();
    });
  }
}
