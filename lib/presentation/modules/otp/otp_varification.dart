// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class OTPVarificationScreen extends StatefulWidget {
  const OTPVarificationScreen(
      {Key? key,
      this.isForgot = true,
      this.email,
      this.passWord,
      this.isGoogle = true,
      this.username,
      this.fcmToken})
      : super(key: key);
  final bool isForgot, isGoogle;
  final String? email, username, fcmToken;
  final String? passWord;

  @override
  State<OTPVarificationScreen> createState() => _OTPVarificationScreenState();
}

class _OTPVarificationScreenState extends State<OTPVarificationScreen> {
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
  TextEditingController txtEnterCodeController = TextEditingController();
  bool isShow = true;

  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  Future<void> resendCode({bool isTrue = false}) async {
    if (isTrue) {
      final fcmToken = await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BMddJ7CcjA7Or2PPl-TwHRW_hWheRqnyxdzRvkRH3u7uxEjIqJvDCmDuWJpV5B-GGCvJfdqpmvC-yUS5qVXF1WE");
      BlocProvider.of<AuthBlocBloc>(context).add(
        LoginWithGoogleResendOtp(
          email: widget.email ?? "",
          username: widget.username ?? "",
          fcmToken: fcmToken!,
        ),
      );
    } else {
      BlocProvider.of<AuthBlocBloc>(context).add(
        ResendOtp(
          email: widget.email ?? '',
          password: widget.passWord ?? '',
        ),
      );
    }
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

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
        appBar: appbar(context),
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
                    Text(
                      widget.email ?? "",
                      style: myTheme.textTheme.bodySmall,
                    ),
                    verticalSpace(0.05.sh),
                    isShow
                        ? Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              ImageSVGManager.otpVerification,
                              height: 0.3.sh,
                              width: 0.3.sw,
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
                          secondsRemaining.toString(),
                          style: myTheme.textTheme.displaySmall,
                        ),
                      ],
                    ),
                    verticalSpace(0.05.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        materialButton(
                          onPressed: () {
                            enableResend ? resendCode(isTrue: true) : null;
                          },
                          minWidth: 0.43.sw,
                          buttonColor: ColorManager.transparentColor,
                          buttonText: AppString.resend,
                        ),
                        materialButton(
                          onPressed: () async {
                            if (widget.isForgot) {
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                ForgotOtpVerify(
                                  email: widget.email ?? "",
                                  otp: int.parse(
                                    txtEnterCodeController.text,
                                  ),
                                ),
                              );
                            } else {
                              if (widget.isGoogle) {
                                final fcmToken =
                                    await FirebaseMessaging.instance.getToken(
                                        vapidKey:
                                            "BMddJ7CcjA7Or2PPl-TwHRW_hWheRqnyxdzRvkRH3u7uxEjIqJvDCmDuWJpV5B-GGCvJfdqpmvC-yUS5qVXF1WE");
                                BlocProvider.of<AuthBlocBloc>(context).add(
                                  LoginWithGoogleOtpSend(
                                    email: widget.email ?? "",
                                    otp: int.parse(txtEnterCodeController.text),
                                    fcmToken: fcmToken!,
                                  ),
                                );
                              } else {
                                final fcmToken =
                                    await FirebaseMessaging.instance.getToken(
                                        vapidKey:
                                            "BMddJ7CcjA7Or2PPl-TwHRW_hWheRqnyxdzRvkRH3u7uxEjIqJvDCmDuWJpV5B-GGCvJfdqpmvC-yUS5qVXF1WE");
                                BlocProvider.of<AuthBlocBloc>(context).add(
                                  VerifyOtp(
                                    email: widget.email ?? "",
                                    otp: int.parse(txtEnterCodeController.text),
                                    fcmToken: fcmToken!,
                                  ),
                                );
                              }
                            }
                          },
                          minWidth: 0.43.sw,
                          buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                          buttonText: AppString.confirm,
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
