import 'package:wallpaper/libs.dart';

Future<bool> onWillPop() {
  AppNavigation.shared.moveToBottomNavigationBarScreen();
  return Future.value(true);
}
