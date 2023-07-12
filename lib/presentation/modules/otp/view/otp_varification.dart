import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper/presentation/common/appbar.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/otp/view/pinput_widget.dart';
import 'package:wallpaper/presentation/modules/otp/view/set_password.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/font_manager.dart';
import 'package:wallpaper/presentation/resources/string_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class OTPVarificationScreen extends StatefulWidget {
  const OTPVarificationScreen({Key? key}) : super(key: key);
  static const route = 'OTPVarificationScreen';

  @override
  State<OTPVarificationScreen> createState() => _OTPVarificationScreenState();
}

class _OTPVarificationScreenState extends State<OTPVarificationScreen> {
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
  TextEditingController txtEnterCodeController = TextEditingController();
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
                key: forgotPassKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.otpVerification,
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      AppString.otpVerificationDesc,
                      style: myTheme.textTheme.labelSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          'dars****@gmail.com. ',
                          style: myTheme.textTheme.labelSmall,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppString.resendCode,
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
                    ),
                    verticalSpace(0.05.sh),
                    isShow
                        ? Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              ImageSVGManager.verification,
                              height: 0.25.sh,
                              width: 0.25.sw,
                            ),
                          )
                        : const SizedBox(),
                    verticalSpace(0.05.sh),
                    enterCode(
                        controller: txtEnterCodeController,
                        onTap: () {
                          setState(() {
                            isShow = false;
                          });
                        }),
                    verticalSpace(0.02.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.resendCodeAfter,
                          style: myTheme.textTheme.labelSmall,
                        ),
                        Text(
                          '00:36',
                          style: TextStyle(
                            color: const Color.fromRGBO(136, 126, 249, 1),
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.roboto,
                            fontWeight: FontWeightManager.regular,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(0.05.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        materialButton(
                          onPressed: () {},
                          minWidth: 70,
                          buttonColor: ColorManager.transparentColor,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 0.035.sh,
                            color: const Color.fromRGBO(160, 152, 250, 1),
                          ),
                        ),
                        materialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SetPasswordScreen(),
                              ),
                            );
                          },
                          minWidth: 70,
                          buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 0.035.sh,
                          ),
                        ),
                      ],
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
