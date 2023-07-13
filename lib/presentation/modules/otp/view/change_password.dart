import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper/presentation/common/appbar.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/login/view/login_screen.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/string_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const route = 'ChangePasswordScreen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(context),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.passwordChanged,
                  style: myTheme.textTheme.titleLarge,
                ),
                verticalSpace(0.01.sh),
                Text(
                  AppString.passwordChangedDesc,
                  style: myTheme.textTheme.labelSmall,
                ),
                verticalSpace(0.05.sh),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ImageSVGManager.changePassword,
                    height: 0.5.sh,
                    width: 0.5.sw,
                  ),
                ),
                verticalSpace(0.15.sh),
                materialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  buttonColor: const Color(0xFFA098FA),
                  buttonText: AppString.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
