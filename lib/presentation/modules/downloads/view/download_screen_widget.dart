import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

Widget bottomContent({
  String? assetName,
  String title = '',
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: padding(paddingType: PaddingType.right, paddingValue: 0.04.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              assetName!,
              color: ColorManager.white,
              height: 0.035.sh,
              width: 0.035.sh,
            )
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.justify,
            style: myTheme.textTheme.labelMedium,
          ),
        ],
      )
    ],
  );
}
