import 'package:walper/libs.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.passwordChanged,
                  style: myTheme.textTheme.titleLarge,
                ),
                verticalSpace(0.01.sh),
                Text(
                  AppString.passwordChangedDesc,
                  style: myTheme.textTheme.labelSmall,
                ),
                verticalSpace(0.05.sh),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ImageSVGManager.changePassword,
                    height: 0.5.sh,
                    width: 0.5.sw,
                  ),
                ),
                verticalSpace(0.15.sh),
                materialButton(
                  onPressed: () {
                    Get.offAll(const LoginScreen());
                  },
                  buttonColor: const Color.fromRGBO(160, 152, 250, 1),
                  buttonText: AppString.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
