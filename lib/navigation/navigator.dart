import 'package:flutter/material.dart';
import 'package:wallpaper/navigation/constants.dart';
import 'package:wallpaper/navigation/fade_route.dart';
import 'package:wallpaper/navigation/slide_transit.dart';
import 'package:wallpaper/presentation/modules/login/view/login_screen.dart';

class NavigationUtilities {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void push(Widget widget, {String? name}) {
    key.currentState!.push(MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ));
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

  static Future<dynamic> pushNamed(String route,
      {RouteType type = RouteType.left, Map? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushNamed(
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
    case LoginScreen.route:
      screen = const LoginScreen();
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
