import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

Widget materialButton(
    {required void Function()? onPressed,
    String buttonText = '',
    Color buttonColor = ColorManager.secondaryColor,
    String? assetName,
    Color? imageColor,
    double minWidth = double.infinity,
    Widget? child}) {
  return MaterialButton(
    onPressed: onPressed,
    color: buttonColor,
    height: 0.07.sh,
    minWidth: minWidth,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(color: ColorManager.secondaryColor),
    ),
    child: child ??
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetName != null)
              Image.asset(
                assetName,
                color: imageColor ?? ColorManager.white,
                scale: 0.025.sh,
              ),
            if (assetName != null) horizontalSpace(0.05.sw),
            Text(buttonText, style: myTheme.textTheme.titleMedium)
          ],
        ),
  );
}
