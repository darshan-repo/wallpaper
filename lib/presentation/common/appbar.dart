import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';

PreferredSizeWidget appbar({
  void Function()? onTap,
}) {
  return AppBar(
    backgroundColor: ColorManager.primaryColor,
    elevation: 0,
    leading: Container(
      margin: margin(marginType: MarginType.LTRB, left: 0.04.sw, top: 0.02.sh),
      decoration: BoxDecoration(
        color: ColorManager.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: ColorManager.white,
        ),
      ),
    ),
  );
}
