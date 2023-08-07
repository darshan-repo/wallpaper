
import 'package:walper/libs.dart';

Widget cachedNetworkImage({
  required String imageUrl,
  Widget? child,
  double width = double.infinity,
  double height = double.infinity,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImageBuilder(
      url: imageUrl,
      builder: (img) => Stack(
        children: [
          Container(
            color: ColorManager.secondaryColor,
            width: width,
            height: height,
            child: Image.file(
              img,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.05),
            ),
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: padding(
                paddingType: PaddingType.LTRB,
                right: 0.01.sw,
                bottom: 0.005.sh,
              ),
              child: child,
            ),
          ),
        ],
      ),
      placeHolder: const CustomLoader(),
      errorWidget: const Icon(Icons.error, color: ColorManager.white),
    ),
  );
}
