import 'package:wallpaper/navigation/navigator.dart';
import 'package:wallpaper/presentation/modules/login/view/login_screen.dart';

class AppNavigation {
  static final AppNavigation shared = AppNavigation();

  moveToLoginScreen() {
    NavigationUtilities.pushNamed(LoginScreen.route);
  }
}
