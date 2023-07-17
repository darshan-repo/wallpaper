import 'package:wallpaper/libs.dart';

class AppNavigation {
  static final AppNavigation shared = AppNavigation();

  void moveToOnBoarding1Screen() {
    NavigationUtilities.pushNamed(OnBoarding1Screen.route);
  }

  void moveToOnBoarding2Screen() {
    NavigationUtilities.pushNamed(OnBoarding2Screen.route);
  }

  void moveToOnBoarding3Screen() {
    NavigationUtilities.pushNamed(OnBoarding3Screen.route);
  }

  void moveToLoginScreen() {
    NavigationUtilities.pushReplacementNamed(LoginScreen.route,
        type: RouteType.up);
  }

  void moveToRegistrationScreen() {
    NavigationUtilities.pushNamed(RegistrationScreen.route, type: RouteType.up);
  }

  void moveToForgotPasswordScreen() {
    NavigationUtilities.pushNamed(EmailVarificationScreen.route);
  }

  void moveToOTPVatificationScreen() {
    NavigationUtilities.pushNamed(OTPVarificationScreen.route);
  }

  void moveToSetPasswordScreen() {
    NavigationUtilities.pushNamed(SetPasswordScreen.route);
  }

  void moveToChangePasswordScreen() {
    NavigationUtilities.pushNamed(ChangePasswordScreen.route);
  }

  void moveToBottomNavigationBarScreen() {
    NavigationUtilities.pushReplacementNamed(BottomNavigationBarScreen.route,
        type: RouteType.up);
  }

  Future moveToCollectionViewScreen(Map<String, dynamic> args) async {
    await NavigationUtilities.pushNamed(CollectionViewScreen.route,
        type: RouteType.right, args: args);
  }

  void moveToNotificationScreen() {
    NavigationUtilities.pushNamed(NotificationScreen.route,
        type: RouteType.down);
  }

  void moveToUpdateProfileScreen() {
    NavigationUtilities.pushNamed(UpdateProfileScreen.route);
  }

  void moveToFavoriteScreen() {
    NavigationUtilities.pushNamed(FavoriteScreen.route, type: RouteType.right);
  }

  void moveToDownloadScreen() {
    NavigationUtilities.pushNamed(DownloadScreen.route, type: RouteType.right);
  }

  void moveToPrivacyPolicyScreen() {
    NavigationUtilities.pushNamed(PrivacyPolicyScreen.route,
        type: RouteType.right);
  }

  void moveToReportAnIssueScreen() {
    NavigationUtilities.pushNamed(ReportAnIssueScreen.route,
        type: RouteType.right);
  }

  void moveToFilterScreen() {
    NavigationUtilities.pushNamed(FilterScreen.route, type: RouteType.down);
  }
}
