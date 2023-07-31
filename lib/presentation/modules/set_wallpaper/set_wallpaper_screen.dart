// ignore_for_file: use_build_context_synchronously

import 'package:walper/libs.dart';

class SetWallpaperScreen extends StatefulWidget {
  final String imgURL, uploaded;
  const SetWallpaperScreen(
      {super.key, required this.imgURL, required this.uploaded});

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  bool isSelect = false;
  bool isLiked = false;
  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }

  void indicatorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: ColorManager.transparentColor,
        title: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pop();
    });
  }

  Future<void> setHomeScreenWallpaper(BuildContext context,
      {required String url}) async {
    setState(() {
      indicatorDialog(context);
    });

    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      'Failed to get wallpaper.';
    }
  }

  Future<void> setLockScreenWallpaper(BuildContext context,
      {required String url}) async {
    setState(() {
      indicatorDialog(context);
    });

    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      'Failed to get wallpaper.';
    }
  }

  Future<void> setBothScreenWallpaper(BuildContext context,
      {required String url}) async {
    setState(() {
      indicatorDialog(context);
    });

    try {
      await AsyncWallpaper.setWallpaper(
        url: widget.imgURL,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      'Failed to get wallpaper.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.imgURL,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: SpinKitCircle(color: ColorManager.white)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: padding(
                paddingType: PaddingType.LTRB,
                left: 0.02.sw,
                right: 0.02.sw,
                top: 0.05.sh,
              ),
              child: Row(
                children: [
                  Container(
                    height: 0.05.sh,
                    width: 0.115.sw,
                    decoration: BoxDecoration(
                      color: ColorManager.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  isSelect
                      ? Container(
                          height: 0.05.sh,
                          padding: padding(
                            paddingType: PaddingType.horizontal,
                            paddingValue: 0.02.sw,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorManager.secondaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Uploaded: ${widget.uploaded}',
                            style: myTheme.textTheme.labelMedium,
                          ),
                        )
                      : const SizedBox(),
                  horizontalSpace(0.01.sw),
                  Container(
                    height: 0.05.sh,
                    width: 0.115.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorManager.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelect = !isSelect;
                        });
                      },
                      child: Icon(
                        isSelect ? Icons.close : Icons.info_outline,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: padding(
                paddingType: PaddingType.LTRB,
                left: 0.02.sw,
                right: 0.02.sw,
                bottom: 0.04.sh,
              ),
              child: materialButton(
                onPressed: () {
                  showModalBottomSheet(
                    elevation: 0,
                    backgroundColor: ColorManager.secondaryColor,
                    context: context,
                    isDismissible: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Container(
                      height: 0.4.sh,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: padding(
                          paddingType: PaddingType.all, paddingValue: 0.02.sh),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          verticalSpace(0.05.sh),
                          GestureDetector(
                            onTap: () async {
                              await setLockScreenWallpaper(context,
                                  url: widget.imgURL);
                              Navigator.pop(context);
                              showAltDialog(
                                context,
                                message:
                                    'Wallpaper Is Set As Lock Screen Successfully.',
                              );
                            },
                            child: Text(
                              'Set as Lock Screen',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.05.sh),
                          GestureDetector(
                            onTap: () async {
                              await setHomeScreenWallpaper(context,
                                  url: widget.imgURL);
                              Navigator.pop(context);
                              showAltDialog(
                                context,
                                message:
                                    'Wallpaper Is Set As Home Screen Successfully.',
                              );
                            },
                            child: Text(
                              'Set as Home Screen',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.05.sh),
                          GestureDetector(
                            onTap: () async {
                              await setBothScreenWallpaper(context,
                                  url: widget.imgURL);
                              Navigator.pop(context);
                              showAltDialog(
                                context,
                                message:
                                    'Wallpaper Is Set As Both Screen Successfully.',
                              );
                            },
                            child: Text(
                              'Set as Both',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.05.sh),
                          Text(
                            'Report this photo',
                            textAlign: TextAlign.justify,
                            style: myTheme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                buttonText: 'Apply',
              ),
            ),
          ),
        ],
      ),
    );
  }
}


   // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Padding(
          //     padding: padding(
          //       paddingType: PaddingType.LTRB,
          //       left: 0.02.sw,
          //       right: 0.03.sw,
          //       bottom: 0.18.sh,
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               isLiked = !isLiked;
          //             });
          //           },
          //           child: isLiked
          //               ? Icon(
          //                   Icons.favorite_rounded,
          //                   size: 0.04.sh,
          //                   color: ColorManager.red,
          //                 )
          //               : Icon(
          //                   Icons.favorite_border_rounded,
          //                   size: 0.04.sh,
          //                   color: ColorManager.white,
          //                 ),
          //         ),
          //         verticalSpace(0.03.sh),
          //         GestureDetector(
          //           onTap: () {},
          //           child: Icon(
          //             Icons.file_download_outlined,
          //             size: 0.04.sh,
          //             color: ColorManager.white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),