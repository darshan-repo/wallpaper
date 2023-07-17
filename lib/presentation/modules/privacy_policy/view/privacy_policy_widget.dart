import 'package:wallpaper/libs.dart';

Widget information({
  String title = '',
  String value = '',
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: padding(paddingType: PaddingType.left, paddingValue: 0.02.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: myTheme.textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 0.85.sw,
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: myTheme.textTheme.headlineSmall,
            ),
          ),
        ],
      )
    ],
  );
}
