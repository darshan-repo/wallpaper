// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ValueNotifier<bool> enableNotificationController = ValueNotifier<bool>(true);
  bool isOn = true;
  bool isEnabledNotification = false;

  @override
  void dispose() {
    enableNotificationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    enableNotificationController.addListener(() {
      setState(() {
        if (enableNotificationController.value) {
          BlocProvider.of<CollectionBlocBloc>(context).add(
            EnabledNotification(
              email: UserPreferences.getUserEmail(),
              deviceId: UserPreferences.getDeviceToken(),
            ),
          );
          isEnabledNotification = true;
        } else {
          BlocProvider.of<CollectionBlocBloc>(context).add(
            DisableNotification(
              email: UserPreferences.getUserEmail(),
            ),
          );
          isEnabledNotification = false;
        }
      });
    });
    super.initState();
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
        ],
      ),
    );
  }
}
