import 'package:walper/libs.dart';

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
        style: myTheme.textTheme.labelLarge,
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
          Icons.keyboard_arrow_down_rounded,
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

Widget conatiner(
  BuildContext context, {
  double height = 0.1,
  double width = 0.30,
  required String assetName,
  Widget? child,
}) {
  return SizedBox(
    width: width.sw,
    height: height.sh,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImageBuilder(
        url: assetName,
        builder: (image) {
          return Stack(
            children: [
              Container(
                color: ColorManager.secondaryColor,
                width: width.sw,
                height: height.sh,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                child: child,
              )
            ],
          );
        },
        placeHolder: const CustomLoader(),
        errorWidget: const Icon(Icons.error),
      ),
    ),
  );
}
