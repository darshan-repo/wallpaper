import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper/presentation/modules/onboarding/onboarding1.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoarding1Screen(),
          ),
        );
      },
    );
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
