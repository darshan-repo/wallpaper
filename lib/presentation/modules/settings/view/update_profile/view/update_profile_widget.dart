import 'package:wallpaper/libs.dart';

Widget profileRow({
  String title = '',
  String value = '',
}) {
  return Padding(
    padding:
        padding(paddingType: PaddingType.horizontal, paddingValue: 0.02.sh),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: myTheme.textTheme.displayMedium,
        ),
        Text(
          value,
          style: myTheme.textTheme.displayMedium,
        ),
      ],
    ),
  );
}
