import 'package:walper/libs.dart';
import 'package:walper/presentation/modules/filter/filter_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  static const route = 'FilterScreen';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  ValueNotifier<bool> controller01 = ValueNotifier<bool>(false);
  ValueNotifier<bool> controller02 = ValueNotifier<bool>(false);
  ValueNotifier<bool> controller03 = ValueNotifier<bool>(false);
  ValueNotifier<bool> controller04 = ValueNotifier<bool>(false);
  ValueNotifier<bool> controller05 = ValueNotifier<bool>(false);
  @override
  void dispose() {
    controller01.dispose();
    controller02.dispose();
    controller03.dispose();
    controller04.dispose();
    controller05.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(
        context,
      ),
      body: Padding(
        padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.01.sh),
            Text(
              'Don\'t see what you need? Add some filters to narrow down your results.',
              style: myTheme.textTheme.labelMedium,
            ),
            verticalSpace(0.07.sh),
            filterRow(title: 'Letest Uploads', controller: controller01),
            verticalSpace(0.05.sh),
            filterRow(title: 'Newest Collection', controller: controller02),
            verticalSpace(0.05.sh),
            filterRow(title: 'Most Downloaded', controller: controller03),
            verticalSpace(0.05.sh),
            filterRow(title: 'Exclusive First', controller: controller04),
            verticalSpace(0.05.sh),
            filterRow(title: 'Sort By Size', controller: controller05),
            const Spacer(),
            materialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              buttonText: 'Apply Filters',
              buttonColor: const Color(0xFFA098FA),
            ),
          ],
        ),
      ),
    );
  }
}
