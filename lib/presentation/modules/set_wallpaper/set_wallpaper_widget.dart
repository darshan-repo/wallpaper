import 'package:walper/libs.dart';

showAltDialog(
  BuildContext context, {
  String message = '',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: ColorManager.secondaryColor,
      iconPadding: padding(
        paddingType: PaddingType.LTRB,
        left: 0.04.sw,
        right: 0.04.sw,
      ),
      icon: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 0.05.sh,
          width: 0.1.sw,
          margin: margin(
            marginType: MarginType.top,
            marginValue: 0.01.sh,
          ),
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
      actionsPadding: padding(
        paddingType: PaddingType.all,
        paddingValue: 0.02.sh,
      ),
      titlePadding:
          padding(paddingType: PaddingType.top, paddingValue: 0.02.sh),
      title: Image.asset(
        ImageAssetManager.setWallpaperDone,
        height: 0.2.sh,
        width: 0.2.sw,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: myTheme.textTheme.titleMedium,
      ),
      elevation: 2,
      shadowColor: ColorManager.white,
      actions: [
        materialButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigationBarScreen(),
              ),
            );
          },
          buttonColor: const Color.fromRGBO(160, 152, 250, 1),
          buttonText: 'Back to home',
        ),
      ],
    ),
  );
}
