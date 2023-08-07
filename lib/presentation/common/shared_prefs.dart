import 'package:walper/libs.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  static late SharedPreferences _prefs;

  reset() {
    _prefs.clear();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setDeviceToken(String setDeviceToken) {
    _prefs.setString("deviceToken", setDeviceToken);
  }

  getDeviceToken() {
    return _prefs.getString("deviceToken") ?? "";
  }

  setUserId(String id) {
    _prefs.setString("userId", id);
  }

  getUserId() {
    return _prefs.getString("userId") ?? "";
  }

  setUserEmail(String userEmail) {
    _prefs.setString("userEmail", userEmail);
  }

  getUserEmail() {
    return _prefs.getString("userEmail") ?? "";
  }

  void setNotificationStatus(bool status) {
    _prefs.setBool("notificationStatus", status);
  }

  static getNotificationStatus() {
    return _prefs.getBool("notificationStatus") ?? "";
  }
}
