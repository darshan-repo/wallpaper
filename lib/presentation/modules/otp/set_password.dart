import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;
  static const route = 'SetPasswordScreen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  GlobalKey<FormState> newPassKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  TextEditingController txtPasswordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              return null;
                            }),
                        verticalSpace(0.02.sh),
                        textFormField(
                            controller: confirmPassWordController,
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
                              } else if (txtPasswordController.text != value) {
                                return "Password are not match";
                              }
                              return null;
                            }),
                        verticalSpace(0.1.sh),
                        materialButton(
                          onPressed: () {
                            final FormState? form = newPassKey.currentState;
                            if (form!.validate()) {
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                  ResetPassWord(
                                      email: widget.email,
                                      password: txtPasswordController.text,
                                      confirmPassword:
                                          confirmPassWordController.text));
                            }
                          },
                          buttonColor: const Color(0xFFA098FA),
                          buttonText: AppString.reserPassword,
                        ),
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
