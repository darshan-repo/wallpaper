import 'package:wallpaper/libs.dart';

class OnBoarding2Screen extends StatelessWidget {
  const OnBoarding2Screen({super.key});
  static const route = 'OnBoarding2Screen';

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
              ImageAssetManager.onBoarding2,
              scale: 0.0001.sh,
            ),
            Text(
              AppString.onBoarding2Title,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.03.sh),
            Text(
              AppString.onBoarding2Desc,
              textAlign: TextAlign.center,
              style: myTheme.textTheme.titleSmall,
            ),
            verticalSpace(0.05.sh),
            materialButton(
              onPressed: () {
                AppNavigation.shared.moveToOnBoarding3Screen();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const OnBoarding3Screen(),
                //   ),
                // );
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
