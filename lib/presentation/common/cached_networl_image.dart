

import 'package:walper/libs.dart';

Widget cachedNetworkImage({
  required String imageUrl,
  bool isLiked = false,
  void Function()? favoritesOnTap,
  void Function()? downloadOnTap,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imageProvider,
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
            bottom: 0.005.sh,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: downloadOnTap,
                child: Icon(
                  Icons.file_download_outlined,
                  size: 0.035.sh,
                  color: ColorManager.white,
                ),
              ),
              verticalSpace(0.02.sh),
              GestureDetector(
                onTap: favoritesOnTap,
                child: isLiked
                    ? const Icon(
                        Icons.favorite_border_rounded,
                        color: ColorManager.white,
                      )
                    : const Icon(
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
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
