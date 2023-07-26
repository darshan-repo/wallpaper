// ignore_for_file: deprecated_member_use

import 'package:walper/libs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ValueNotifier<bool> themeController = ValueNotifier<bool>(false);
  ValueNotifier<bool> enableNotificationController = ValueNotifier<bool>(false);
  ValueNotifier<bool> autoChangeWallpaperController =
      ValueNotifier<bool>(false);
  @override
  void dispose() {
    themeController.dispose();
    enableNotificationController.dispose();
    autoChangeWallpaperController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.02.sh),
          ListTile(
            leading:  SvgPicture.asset(
              SVGIconManager.autoChangeWallpaper,
              color: ColorManager.white,
            ),
            title: Text(
              'Auto Change Wallpaper',
              style: myTheme.textTheme.displayMedium,
            ),
            trailing: AdvancedSwitch(
              width: 56,
              height: 32,
              controller: autoChangeWallpaperController,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            leading: SvgPicture.asset(
              SVGIconManager.settingNotification,
              color: ColorManager.white,
            ),
            title: Text(
              'Enable Notification',
              style: myTheme.textTheme.displayMedium,
            ),
            trailing: AdvancedSwitch(
              width: 56,
              height: 32,
              controller: enableNotificationController,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: ColorManager.secondaryColor,
                  title: Text(
                    'Rate this App',
                    textAlign: TextAlign.center,
                    style: myTheme.textTheme.titleMedium,
                  ),
                  contentPadding: padding(
                      paddingType: PaddingType.all, paddingValue: 0.02.sh),
                  content: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    glow: false,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  elevation: 2,
                  shadowColor: ColorManager.white,
                  actions: [
                    materialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigationBarScreen(),
                          ),
                        );
                      },
                      minWidth: 0.02.sw,
                      buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                      buttonText: 'Ok',
                    ),
                  ],
                ),
              );
            },
            leading:  SvgPicture.asset(
              SVGIconManager.rateThisApp,
              color: ColorManager.white,
            ),
            title: Text(
              'Rate this App',
              style: myTheme.textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
