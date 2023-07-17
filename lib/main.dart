import 'package:wallpaper/libs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const WallPaper());
}

class WallPaper extends StatelessWidget {
  const WallPaper({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          navigatorKey: NavigationUtilities.key,
          onGenerateRoute: onGenerateRoute,
          navigatorObservers: [routeObserver],
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
