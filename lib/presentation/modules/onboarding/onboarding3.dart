import 'package:walper/libs.dart';

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
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool(
                  "userID",
                  true,
                );
                Get.offAll(const BottomNavigationBarScreen());
              },
              buttonText: AppString.getStarted,
            ),
            verticalSpace(0.03.sh),
          ],
        ),
      ),
    );
  }
}
