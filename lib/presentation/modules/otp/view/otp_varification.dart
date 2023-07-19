import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/libs.dart';
import 'package:wallpaper/logic/auth_bloc/bloc/auth_bloc_bloc.dart';

class OTPVarificationScreen extends StatefulWidget {
  const OTPVarificationScreen(
      {Key? key, this.isForgot = true, this.email, this.passWord})
      : super(key: key);
  final bool isForgot;
  final String? email;
  final String? passWord;
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
                      style: myTheme.textTheme.labelSmall,
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
                          '00:36',
                          style: myTheme.textTheme.displaySmall,
                        ),
                      ],
                    ),
                    verticalSpace(0.05.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        materialButton(
                          onPressed: () {},
                          minWidth: 0.43.sw,
                          buttonColor: ColorManager.transparentColor,
                          buttonText: AppString.resend,
                        ),
                        materialButton(
                          onPressed: () {
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
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                VerifyOtp(
                                  email: widget.email ?? "",
                                  passWord: widget.passWord ?? "",
                                  otp: int.parse(
                                    txtEnterCodeController.text,
                                  ),
                                ),
                              );
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
