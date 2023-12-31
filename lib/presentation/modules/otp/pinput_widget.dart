import 'package:walper/libs.dart';

Widget enterCode({
  required TextEditingController controller,
  void Function()? onTap,
}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Pinput(
      controller: controller,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      validator: (value) {
        return value == controller.text ? null : '';
      },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onTap: onTap,
      keyboardType: TextInputType.number,
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: myTheme.textTheme.titleMedium,
        decoration: BoxDecoration(
          color: ColorManager.secondaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.secondaryColor,
          ),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: myTheme.textTheme.titleMedium,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.secondaryColor,
          ),
        ),
      ),
      disabledPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: myTheme.textTheme.titleMedium,
        decoration: BoxDecoration(
          color: ColorManager.secondaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.secondaryColor,
          ),
        ),
      ),
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: myTheme.textTheme.titleMedium,
        decoration: BoxDecoration(
          color: ColorManager.secondaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.secondaryColor,
          ),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: myTheme.textTheme.titleMedium,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.red,
          ),
        ),
      ),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ),
  );
}
