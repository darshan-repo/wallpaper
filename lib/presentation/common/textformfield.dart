import 'package:flutter/material.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

Widget textFormField(
    {TextEditingController? controller,
    String hintText = '',
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    void Function()? suffixOnPressed,
    void Function()? onTap}) {
  return TextFormField(
    onTap: onTap,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: myTheme.textTheme.labelMedium,
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
