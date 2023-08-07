// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? isNotify;

  var isNotificationTrue;

  @override
  void initState() {
    if (UserPreferences.getNotificationStatus().toString().isNotEmpty) {
      setState(() {
        isNotificationTrue = UserPreferences.getNotificationStatus();
        isNotify = isNotificationTrue;
      });
    } else {
      setState(() {
        isNotify = true;
      });
    }
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
            AppString.settings,
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.02.sh),
          BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
            builder: (context, state) {
              return ListTile(
                leading: SvgPicture.asset(
                  SVGIconManager.settingNotification,
                  color: ColorManager.white,
                ),
                title: Text(
                  AppString.enableNotification,
                  style: myTheme.textTheme.displayMedium,
                ),
                trailing: CupertinoSwitch(
                  value: isNotify!,
                  onChanged: (value) {
                    setState(
                      () {
                        isNotify = value;
                        UserPreferences().setNotificationStatus(value);
                      },
                    );
                    if (value) {
                      BlocProvider.of<CollectionBlocBloc>(context).add(
                        EnabledNotification(
                          email: UserPreferences().getUserEmail(),
                          deviceId: UserPreferences().getDeviceToken(),
                        ),
                      );
                    } else {
                      BlocProvider.of<CollectionBlocBloc>(context).add(
                        DisableNotification(
                          email: UserPreferences().getUserEmail(),
                        ),
                      );
                    }
                  },
                  thumbColor: Colors.white,
                  activeColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
