import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/libs.dart';
import 'package:wallpaper/logic/auth_bloc/bloc/auth_bloc_bloc.dart';

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
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        appBar: appbar(context),
        body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthBlocLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                            controller: nameController,
                            hintText: AppString.username,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "User name cannot be empty";
                              }
                              return null;
                            }),
                        verticalSpace(0.02.sh),
                        textFormField(
                            controller: emailController,
                            hintText: AppString.email,
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
                            controller: passwordController,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              return null;
                            }),
                        verticalSpace(0.02.sh),
                        textFormField(
                            controller: confirmPassword,
                            hintText: AppString.confirmPassword,
                            obscureText: isConfirmPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            suffixIcon: isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_outlined,
                            suffixOnPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm password cannot be empty";
                              } else if (passwordController.text != value) {
                                return "Password are not match";
                              }
                              return null;
                            }),
                        verticalSpace(0.05.sh),
                        materialButton(
                          onPressed: () {
                            final FormState? form =
                                registerFormKey.currentState;
                            if (form!.validate()) {
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                UserSignUp(
                                  name: nameController.text,
                                  email: emailController.text,
                                  passWord: passwordController.text,
                                ),
                              );
                            }
                          },
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
                        verticalSpace(0.025.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            materialButton(
                              onPressed: () {},
                              minWidth: 0.05.sw,
                              buttonColor:
                                  const Color.fromRGBO(59, 130, 246, 1),
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
                        verticalSpace(0.035.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.alreadyHaveAnAccount,
                              style: myTheme.textTheme.labelMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                AppNavigation.shared.moveToLoginScreen();
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
            );
          },
        ),
      ),
    );
  }
}
