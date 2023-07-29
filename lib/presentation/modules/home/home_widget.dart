import 'package:walper/libs.dart';

Widget

dropDownButton({
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
        width: 0.35.sw,
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

Widget conatiner({
  double height = 0.1,
  double width = 0.29,
  required String assetName,
  Widget? child,
}) {
  return Container(
    height: height.sh,
    width: width.sw,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: AssetImage(assetName),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
