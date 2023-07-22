import 'package:walper/libs.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});
  static const route = 'FeaturedScreen';

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(
        context,
      ),
      body: Padding(
        padding: padding(
          paddingType: PaddingType.all,
          paddingValue: 0.02.sh,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: 10,
            itemBuilder: (context, index) => homeGridview(
              assetName: ImageJPGManager.bananas,
            ),
          ),
        ),
      ),
    );
  }
}
