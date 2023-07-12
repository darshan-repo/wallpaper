import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/appbar.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/common/textformfield.dart';
import 'package:wallpaper/presentation/modules/login/view/login_screen.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/font_manager.dart';
import 'package:wallpaper/presentation/resources/string_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const route = 'RegistrationScreen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                key: registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.gettingStarted,
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      AppString.createAnAccountToContinue,
                      style: myTheme.textTheme.labelSmall,
                    ),
                    verticalSpace(0.05.sh),
                    textFormField(
                      controller: txtEmailIdController,
                      hintText: AppString.username,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtEmailIdController,
                      hintText: AppString.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticalSpace(0.02.sh),
                    textFormField(
                      controller: txtPasswordController,
                      hintText: AppString.password,
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
                      hintText: AppString.confirmPassword,
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
                    verticalSpace(0.05.sh),
                    materialButton(
                      onPressed: () {},
                      buttonColor: const Color.fromRGBO(136, 126, 249, 1),
                      buttonText: AppString.register,
                    ),
                    verticalSpace(0.04.sh),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.orContinueWithSocialAccount,
                        style: myTheme.textTheme.labelSmall,
                      ),
                    ),
                    verticalSpace(0.04.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        materialButton(
                          onPressed: () {},
                          minWidth: 0.05.sw,
                          buttonColor: const Color.fromRGBO(59, 130, 246, 1),
                          assetName: ImageAssetManager.facebook,
                          imageColor: ColorManager.white,
                          buttonText: AppString.facebook,
                        ),
                        materialButton(
                          onPressed: () {},
                          minWidth: 70,
                          buttonColor: ColorManager.primaryColor,
                          assetName: ImageAssetManager.google,
                          buttonText: AppString.google,
                        ),
                      ],
                    ),
                    verticalSpace(0.03.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.alreadyHaveAnAccount,
                          style: myTheme.textTheme.labelMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppString.signIn,
                            style: TextStyle(
                              color: const Color.fromRGBO(136, 126, 249, 1),
                              fontSize: FontSize.s16,
                              fontFamily: FontFamily.roboto,
                              fontWeight: FontWeightManager.regular,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    )
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
