import 'package:wallpaper/libs.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({Key? key}) : super(key: key);
  static const route = 'EmailVarificationScreen';

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
                        }),
                    verticalSpace(0.04.sh),
                    materialButton(
                      onPressed: () {
                        txtEmailIdController.text != 'darshankikani@gmail.com'
                            ? showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => alertDialog(
                                  context,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    AppNavigation.shared
                                        .moveToRegistrationScreen();
                                  },
                                ),
                              )
                            : AppNavigation.shared
                                .moveToOTPVatificationScreen();
                      },
                      buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                      buttonText: 'Send Code',
                    ),
                    verticalSpace(0.06.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember Password?  ',
                          style: myTheme.textTheme.labelMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.shared.moveToLoginScreen();
                          },
                          child: Text(
                            'Login',
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
        ),
      ),
    );
  }
}

Widget alertDialog(
  BuildContext context, {
  String buttonText = '',
  Function()? onPressed,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: ColorManager.primaryColor,
    iconPadding: padding(
      paddingType: PaddingType.LTRB,
      left: 0.04.sw,
      right: 0.04.sw,
    ),
    icon: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImageAssetManager.emailError,
          scale: 0.009.sh,
        ),
        horizontalSpace(0.16.sw),
        Container(
          height: 0.05.sh,
          width: 0.1.sw,
          margin: margin(
            marginType: MarginType.top,
            marginValue: 0.01.sh,
          ),
          decoration: BoxDecoration(
            color: ColorManager.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    ),
    actionsPadding: padding(
      paddingType: PaddingType.all,
      paddingValue: 0.02.sh,
    ),
    content: Text(
      'No Account found registered with your email address',
      textAlign: TextAlign.center,
      style: myTheme.textTheme.labelMedium,
    ),
    elevation: 2,
    shadowColor: ColorManager.white,
    actions: [
      materialButton(
        onPressed: onPressed,
        buttonColor: const Color.fromRGBO(160, 152, 250, 1),
        buttonText: AppString.signUp,
      ),
    ],
  );
}
