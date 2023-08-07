import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
  TextEditingController txtEmailIdController = TextEditingController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(AppString.pattern);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          isShow = !isShow;
        });
      },
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(context),
        body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthBlocLoading) {
              return const CustomLoader();
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
                    key: forgotPassKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.forgotPassword,
                          style: myTheme.textTheme.titleLarge,
                        ),
                        verticalSpace(0.01.sh),
                        Text(
                          AppString.forgotPasswordDesc,
                          style: myTheme.textTheme.labelSmall,
                        ),
                        verticalSpace(0.05.sh),
                        isShow
                            ? Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  ImageSVGManager.forgotPassword,
                                  height: 0.3.sh,
                                  width: 0.3.sw,
                                ),
                              )
                            : const SizedBox(),
                        verticalSpace(0.05.sh),
                        textFormField(
                            controller: txtEmailIdController,
                            hintText: AppString.enterYourEmail,
                            keyboardType: TextInputType.emailAddress,
                            onTap: () {
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppString.emailCannotBeEmpty;
                              } else if (!regex.hasMatch(value)) {
                                return AppString.enterAValidEmail;
                              }
                              return null;
                            }),
                        verticalSpace(0.04.sh),
                        materialButton(
                          onPressed: () {
                            final FormState? form = forgotPassKey.currentState;
                            if (form!.validate()) {
                              BlocProvider.of<AuthBlocBloc>(context).add(
                                ForgotOtpSend(
                                  email: txtEmailIdController.text,
                                  context: context,
                                ),
                              );
                            }
                          },
                          buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                          buttonText: AppString.sendCode,
                        ),
                        verticalSpace(0.06.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.rememberPassword,
                              style: myTheme.textTheme.labelMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const LoginScreen());
                              },
                              child: Text(
                                AppString.login,
                                style: myTheme.textTheme.displaySmall,
                              ),
                            ),
                          ],
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
