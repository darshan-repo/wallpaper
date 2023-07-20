import 'package:walper/libs.dart';

Widget textFormField({
  TextEditingController? controller,
  String hintText = '',
  IconData? suffixIcon,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  void Function()? suffixOnPressed,
  int maxLines = 1,
  void Function()? onTap,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    onTap: onTap,
    maxLines: maxLines,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: myTheme.textTheme.labelMedium,
    validator: validator,
    cursorColor: ColorManager.white,
    decoration: InputDecoration(
      filled: true,
      fillColor: ColorManager.secondaryColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: ColorManager.secondaryColor, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: ColorManager.secondaryColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: ColorManager.secondaryColor, width: 1),
      ),
      suffixIcon: GestureDetector(
        onTap: suffixOnPressed,
        child: Icon(suffixIcon, color: ColorManager.white),
      ),
      hintText: hintText,
      hintStyle: myTheme.textTheme.labelMedium,
    ),
  );
}
