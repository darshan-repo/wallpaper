import 'package:walper/libs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      UserPreferences.getUserEnter() == true
          ? Get.to(const OnBoarding1Screen())
          : Get.to(const BottomNavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageAssetManager.splashLogo,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
    );
  }
}
