import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

Widget dropDownButton({
  String? selectedValue,
  required List<DropdownMenuItem<String>>? items,
  void Function(String?)? onChanged,
}) {
  return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        selectedValue!,
        style: myTheme.textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      items: items,
      value: selectedValue,
      onChanged: onChanged,
      buttonStyleData: ButtonStyleData(
        height: 0.05.sh,
        width: 0.4.sw,
        overlayColor: MaterialStateProperty.all(ColorManager.primaryColor),
        decoration: const BoxDecoration(
          color: ColorManager.primaryColor,
        ),
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        iconSize: 0.05.sh,
        iconEnabledColor: ColorManager.white,
        iconDisabledColor: ColorManager.white,
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        decoration: BoxDecoration(
          color: ColorManager.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
