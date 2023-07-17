import 'package:wallpaper/libs.dart';


class PhotosSearchScreen extends StatefulWidget {
  const PhotosSearchScreen({super.key});

  @override
  State<PhotosSearchScreen> createState() => _PhotosSearchScreenState();
}

class _PhotosSearchScreenState extends State<PhotosSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImageJPGManager.yellowPinkColor),
              ),
            ),
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
                    const Icon(
                      Icons.file_download_outlined,
                      color: ColorManager.white,
                    ),
                    verticalSpace(0.01.sh),
                    const Icon(
                      Icons.favorite_rounded,
                      color: ColorManager.red,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
