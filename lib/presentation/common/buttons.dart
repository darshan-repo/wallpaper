import 'package:walper/libs.dart';

Widget materialButton({
  Function()? onPressed,
  String buttonText = '',
  Color buttonColor = ColorManager.secondaryColor,
  String? assetName,
  Color? disabledColor,
  Color? imageColor,
  double minWidth = double.infinity,
  Widget? child,
  bool isEnabled = false,
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: buttonColor,
    height: 0.07.sh,
    minWidth: minWidth,
    disabledColor: disabledColor,
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
              imageColor == null
                  ? Image.asset(
                      assetName,
                      scale: 0.025.sh,
                    )
                  : Image.asset(
                      assetName,
                      color: imageColor,
                      scale: 0.025.sh,
                    ),
            if (assetName != null) horizontalSpace(0.05.sw),
            Text(buttonText, style: myTheme.textTheme.titleMedium)
          ],
        ),
  );
}
