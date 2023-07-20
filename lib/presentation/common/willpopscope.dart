import 'package:walper/libs.dart';

Future<bool> onWillPop() {
  Get.off(const BottomNavigationBarScreen());
  return Future.value(true);
}
