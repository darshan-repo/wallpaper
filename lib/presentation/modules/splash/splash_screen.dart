// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/logic/pagination/pagination_bloc.dart';
import 'package:walper/logic/pagination/pagination_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    Timer(
      const Duration(seconds: 3),
      () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        if (pref.getBool("user") == true) {
          BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured());
          Get.to(() => const BottomNavigationBarScreen());
        } else {
          Get.to(() => const OnBoarding1Screen());
        }
      },
    );
    super.initState();
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
