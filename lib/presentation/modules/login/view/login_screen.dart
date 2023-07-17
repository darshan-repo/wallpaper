import 'package:wallpaper/libs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                    ),
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
                    ),
                    verticalSpace(0.02.sh),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          AppNavigation.shared.moveToForgotPasswordScreen();
                        },
                        child: Text(
                          AppString.forgotYourPassword,
                          style: myTheme.textTheme.labelMedium,
                        ),
                      ),
                    ),
                    verticalSpace(0.05.sh),
                    materialButton(
                      onPressed: () {
                        AppNavigation.shared.moveToBottomNavigationBarScreen();
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
                          AppString.donttHaveAnAccount,
                          style: myTheme.textTheme.labelMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.shared.moveToRegistrationScreen();
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
        ),
      ),
    );
  }
}
