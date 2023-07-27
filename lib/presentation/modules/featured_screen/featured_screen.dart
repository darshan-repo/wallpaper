import 'package:flutter_spinkit/flutter_spinkit.dart';
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
            itemBuilder: (context, index) => CachedNetworkImage(
              imageUrl: ImageJPGManager.bananas,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: imageProvider,
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
                        paddingType: PaddingType.LTRB,
                        right: 0.01.sw,
                        bottom: 0.005.sh),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Icon(
                            size: 0.035.sh,
                            Icons.file_download_outlined,
                            color: ColorManager.white,
                          ),
                        ),
                        verticalSpace(0.02.sh),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: ColorManager.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: SpinKitCircle(color: ColorManager.white)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
