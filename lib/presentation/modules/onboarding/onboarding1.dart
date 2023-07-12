import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/onboarding/onboarding2.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/string_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class OnBoarding1Screen extends StatelessWidget {
  const OnBoarding1Screen({super.key});

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
            Text(
              AppString.onBoarding1Title,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.03.sh),
            Text(
              AppString.onBoarding1Desc,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleSmall,
            ),
            verticalSpace(0.05.sh),
            materialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnBoarding2Screen(),
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
