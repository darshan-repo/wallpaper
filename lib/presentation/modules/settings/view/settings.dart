import 'package:wallpaper/libs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static const String route = 'SettingScreen';

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
            leading: Image.asset(
              ImageAssetManager.updateProfile,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            ),
            title: Text(
              'Update Profile',
              style: myTheme.textTheme.displayMedium,
            ),
            trailing: GestureDetector(
              onTap: () {
                AppNavigation.shared.moveToUpdateProfileScreen();
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorManager.white,
              ),
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            leading: Image.asset(
              ImageAssetManager.language,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            ),
            title: Text(
              'Language',
              style: myTheme.textTheme.displayMedium,
            ),
            subtitle: Text(
              'English',
              style: myTheme.textTheme.headlineSmall,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorManager.white,
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            leading: Image.asset(
              ImageAssetManager.theme,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            ),
            title: Text(
              'Dark Theme',
              style: myTheme.textTheme.displayMedium,
            ),
            trailing: AdvancedSwitch(
              width: 56,
              height: 32,
              controller: themeController,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            leading: Image.asset(
              ImageAssetManager.autoUpdate,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
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
            leading: Image.asset(
              ImageAssetManager.notification,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
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
            leading: Image.asset(
              ImageAssetManager.star,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            ),
            title: Text(
              'Rate this App',
              style: myTheme.textTheme.displayMedium,
            ),
          ),
          const Divider(
            color: ColorManager.secondaryColor,
          ),
          ListTile(
            leading: Image.asset(
              ImageAssetManager.share,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            ),
            title: Text(
              'Share with friend',
              style: myTheme.textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
