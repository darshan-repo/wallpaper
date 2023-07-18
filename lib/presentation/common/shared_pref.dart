import 'package:wallpaper/libs.dart';

class SharedPref {
  static SharedPreferences? pref;

  static Future<SharedPreferences> get init async =>
      pref = await SharedPreferences.getInstance();

  static set setIsScanned(bool data) => pref!.setBool(SharedKey.isTrue, data);

  static bool? get getIsScanned => pref!.getBool(SharedKey.isTrue);
}

class SharedKey {
  static const isTrue = 'isTrue';
}
