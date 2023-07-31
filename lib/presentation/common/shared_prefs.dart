// ignore_for_file: avoid_print

import 'package:walper/libs.dart';

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

  static getDeviceToken() {
    return _prefs.getString("setDeviceToken") ?? "";
  }

  static setUserId(String id) {
    _prefs.setString("userId", id);
    print("=======>> userId set <<=======");
  }

  static setDeviceToken(String setDeviceToken) {
    _prefs.setString("setDeviceToken", setDeviceToken);
    print("=======>> setDeviceToken set <<=======");
  }

  static setUserEntered(String id) {
    _prefs.setBool(id, true);
  }

  static getUserEnter() {
    return _prefs.getBool('id');
  }

  static setUserEmail(String userEmail) {
    _prefs.setString("userEmail", userEmail);
    print("=======>> userEmail set <<=======");
  }

  static getUserEmail() {
    return _prefs.getString("userEmail") ?? "";
  }
}
