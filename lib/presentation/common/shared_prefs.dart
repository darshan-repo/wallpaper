// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  static late SharedPreferences _prefs;

  reset() {
    print("==============>> shared prefs cleared <<===============");
    _prefs.clear();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
    print(
        "===================>> shared preference instance created <<===================");
  }

  static getUserId() {
    return _prefs.getString("userId") ?? "";
  }




  void setUserId(String id) {
    _prefs.setString("userId", id);
    print("=======>> userId set <<=======");
  }


  void setToken(String token) {
    _prefs.setString("token", token);
    print("=======>> token set <<=======");
  }

  getToken() {
    return _prefs.getString("token");
  }
}
