import 'package:walper/libs.dart';

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
