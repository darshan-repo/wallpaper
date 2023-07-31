// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(context, leadingOnTap: () {
          Get.offAll(const BottomNavigationBarScreen());
        }),
        body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthBlocLoading) {
              return const Center(
                child: SpinKitCircle(color: ColorManager.white),
              );
            }
            return Padding(
              padding:
                  padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.letsSignYouIn,
                          style: myTheme.textTheme.titleLarge,
                        ),
                        verticalSpace(0.01.sh),
                        Text(
                          AppString.welcomeBackYouveBeenMissed,
                          style: myTheme.textTheme.labelSmall,
                        ),
                        verticalSpace(0.05.sh),
                        textFormField(
                            controller: txtEmailIdController,
                            hintText: AppString.enterYourEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!regex.hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            }),
                        verticalSpace(0.02.sh),
                        textFormField(
                            controller: txtPasswordController,
                            hintText: AppString.enterYourPassword,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              return null;
                            }),
                        verticalSpace(0.02.sh),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const EmailVarificationScreen());
                            },
                            child: Text(
                              AppString.forgotYourPassword,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                        verticalSpace(0.05.sh),
                        materialButton(
                          onPressed: () async {
                            final fcmToken = await FirebaseMessaging.instance
                                .getToken(
                                    vapidKey:
                                        "BMddJ7CcjA7Or2PPl-TwHRW_hWheRqnyxdzRvkRH3u7uxEjIqJvDCmDuWJpV5B-GGCvJfdqpmvC-yUS5qVXF1WE");
                            final FormState? form = loginFormKey.currentState;
                            if (form!.validate()) {
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                LoginWithOtp(
                                  email: txtEmailIdController.text,
                                  context: context,
                                  passWord: txtPasswordController.text,
                                  fcmToken: fcmToken!,
                                ),
                              );
                            }
                          },
                          buttonColor: const Color.fromRGBO(136, 126, 249, 1),
                          buttonText: AppString.login,
                        ),
                        verticalSpace(0.05.sh),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppString.orContinueWithSocialAccount,
                            style: myTheme.textTheme.labelSmall,
                          ),
                        ),
                        verticalSpace(0.025.sh),
                        materialButton(
                          onPressed: () {},
                          buttonColor: const Color.fromRGBO(59, 130, 246, 1),
                          assetName: ImageAssetManager.facebook,
                          imageColor: ColorManager.white,
                          buttonText: AppString.signInWithFacebook,
                        ),
                        verticalSpace(0.025.sh),
                        materialButton(
                          onPressed: () {},
                          buttonColor: ColorManager.primaryColor,
                          assetName: ImageAssetManager.google,
                          buttonText: AppString.signInWithGoogle,
                        ),
                        verticalSpace(0.035.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.dontHaveAnAccount,
                              style: myTheme.textTheme.labelMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const RegistrationScreen());
                              },
                              child: Text(
                                AppString.signUp,
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
            );
          },
        ),
      ),
    );
  }
}
