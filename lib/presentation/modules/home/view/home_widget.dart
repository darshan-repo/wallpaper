import 'package:wallpaper/libs.dart';

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

Widget homeGridview({
  double height = 0.0,
  required String assetName,
  void Function()? downloadOnTap,
  void Function()? favoriteOnTap,
  bool isSelect = false,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(assetName),
      ),
    ),
    alignment: Alignment.bottomRight,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.05),
      ),
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: padding(
            paddingType: PaddingType.LTRB, right: 0.01.sw, bottom: 0.005.sh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: downloadOnTap,
              child: Icon(
                size: 0.035.sh,
                Icons.file_download_outlined,
                color: ColorManager.white,
              ),
            ),
            verticalSpace(0.02.sh),
            GestureDetector(
              onTap: favoriteOnTap,
              child: isSelect
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: ColorManager.red,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: ColorManager.white,
                    ),
            ),
          ],
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
