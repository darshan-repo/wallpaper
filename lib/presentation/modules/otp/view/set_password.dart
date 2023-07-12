import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/appbar.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/common/textformfield.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);
  static const route = 'SetPasswordScreen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  GlobalKey<FormState> newPassKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController txtPasswordController = TextEditingController();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          isShow = true;
        });
      },
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Form(
                key: newPassKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set New Password',
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      'Your new password must be unique from those\npreviously used.',
                      style: myTheme.textTheme.labelSmall,
                    ),
                    verticalSpace(0.05.sh),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtPasswordController,
                      hintText: 'password',
                      obscureText: isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_outlined,
                      suffixOnPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtPasswordController,
                      hintText: 'confirm password',
                      obscureText: isConfirmPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_outlined,
                      suffixOnPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    verticalSpace(0.1.sh),
                    materialButton(
                      onPressed: () {},
                      buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                      buttonText: 'Reset Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
