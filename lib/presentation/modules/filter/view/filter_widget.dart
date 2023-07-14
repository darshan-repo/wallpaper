import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

Widget filterRow({
  ValueNotifier<bool>? controller,
  String title = '',
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: myTheme.textTheme.displayMedium,
      ),
      AdvancedSwitch(
        width: 56,
        height: 32,
        controller: controller,
        borderRadius: BorderRadius.circular(18),
      ),
    ],
  );
}
