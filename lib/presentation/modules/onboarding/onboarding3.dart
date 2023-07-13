import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/login/view/login_screen.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/string_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class OnBoarding3Screen extends StatelessWidget {
  const OnBoarding3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Padding(
        padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssetManager.onBoarding3,
              scale: 0.0001.sh,
            ),
            Text(
              AppString.onBoarding3Title,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.03.sh),
            Text(
              AppString.onBoarding3Desc,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleSmall,
            ),
            verticalSpace(0.05.sh),
            materialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              buttonText: 'Get Started',
            ),
            verticalSpace(0.03.sh),
          ],
        ),
      ),
    );
  }
}
