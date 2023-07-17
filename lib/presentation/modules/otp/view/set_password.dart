import 'package:wallpaper/libs.dart';

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
                key: newPassKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.setNewPassword,
                      style: myTheme.textTheme.titleLarge,
                    ),
                    verticalSpace(0.01.sh),
                    Text(
                      AppString.setNewPasswordDesc,
                      style: myTheme.textTheme.labelSmall,
                    ),
                    verticalSpace(0.05.sh),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        ImageSVGManager.resetPassword,
                        height: 0.3.sh,
                        width: 0.3.sw,
                      ),
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
                    verticalSpace(0.1.sh),
                    materialButton(
                      onPressed: () {
                        AppNavigation.shared.moveToChangePasswordScreen();
                      },
                      buttonColor: const Color(0xFFA098FA),
                      buttonText: AppString.reserPassword,
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
