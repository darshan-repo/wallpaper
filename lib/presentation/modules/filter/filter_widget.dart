import 'package:walper/libs.dart';

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
