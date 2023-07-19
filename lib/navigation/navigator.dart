import 'package:wallpaper/libs.dart';

class NavigationUtilities {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void push(Widget widget, {String? name}) {
    key.currentState!.push(MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ));
  }

  static Future<dynamic>? pushNamed(String route,
      {RouteType type = RouteType.left, Map<String, dynamic>? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushNamed(
      route,
      arguments: args,
    );
  }

  static Future<dynamic> pushRoute(String route,
      {RouteType type = RouteType.left, Map? args}) async {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return await key.currentState!.pushNamed(
      route,
      arguments: args,
    );
  }

  static Future<dynamic>? pushReplacementNamed(String route,
      {RouteType type = RouteType.left, Map? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  static Future<dynamic>? pushNamedAndRemoveUntil(String route,
      {RouteType type = RouteType.left, Map? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushNamedAndRemoveUntil(
      route,
      ModalRoute.withName(HomeScreen.route),
      arguments: args,
    );
  }

  static RoutePredicate namePredicate(List<String> names) {
    return (route) =>
        !route.willHandlePopInternally &&
        route is ModalRoute &&
        (names.contains(route.settings.name));
  }
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final routeName = settings.name;
  final arguments = settings.arguments as Map<String, dynamic>? ?? {};
  final routeType =
      arguments["routeType"] as RouteType? ?? RouteType.defaultRoute;

  Widget? screen;

  switch (routeName) {
    case OnBoarding1Screen.route:
      screen = const OnBoarding1Screen();
      break;
    case OnBoarding2Screen.route:
      screen = const OnBoarding2Screen();
      break;
    case OnBoarding3Screen.route:
      screen = const OnBoarding3Screen();
      break;
    case LoginScreen.route:
      screen = const LoginScreen();
      break;
    case RegistrationScreen.route:
      screen = const RegistrationScreen();
      break;
    case EmailVarificationScreen.route:
      screen = const EmailVarificationScreen();
      break;
    case OTPVarificationScreen.route:
      screen = const OTPVarificationScreen();
      break;
    case ChangePasswordScreen.route:
      screen = const ChangePasswordScreen();
      break;
    case BottomNavigationBarScreen.route:
      screen = const BottomNavigationBarScreen();
      break;
    case CollectionViewScreen.route:
      screen = CollectionViewScreen(args: arguments);
      break;
    case NotificationScreen.route:
      screen = const NotificationScreen();
      break;
    case UpdateProfileScreen.route:
      screen = const UpdateProfileScreen();
      break;
    case FavoriteScreen.route:
      screen = const FavoriteScreen();
      break;
    case DownloadScreen.route:
      screen = const DownloadScreen();
      break;
    case PrivacyPolicyScreen.route:
      screen = const PrivacyPolicyScreen();
      break;
    case ReportAnIssueScreen.route:
      screen = const ReportAnIssueScreen();
      break;
    case FilterScreen.route:
      screen = const FilterScreen();
      break;
    case FeaturedScreen.route:
      screen = const FeaturedScreen();
      break;
    case SetWallpaperScreen.route:
      screen = SetWallpaperScreen(imgURL: arguments);
      break;
  }

  switch (routeType) {
    case RouteType.fade:
      return FadeRoute(
        builder: (_) => screen!,
        settings: RouteSettings(name: routeName),
      );
    case RouteType.left:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.left,
      );

    case RouteType.down:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.down,
      );
    case RouteType.up:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.up,
      );
    case RouteType.right:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.right,
      );

    case RouteType.defaultRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => screen!,
        settings: RouteSettings(name: routeName),
      );
  }
}
