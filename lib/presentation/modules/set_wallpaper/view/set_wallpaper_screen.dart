import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/bottom_navigaton_bar/view/bottom_navigation_bar.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class SetWallpaperScreen extends StatefulWidget {
  final String imgURL;
  const SetWallpaperScreen({super.key, required this.imgURL});

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  String platformVersion = 'Unknown';
  String wallpaperFileNative = 'Unknown';
  String wallpaperFileHome = 'Unknown';
  String wallpaperFileLock = 'Unknown';
  String wallpaperFileBoth = 'Unknown';
  String wallpaperUrlNative = 'Unknown';
  String wallpaperUrlHome = 'Unknown';
  String wallpaperUrlLock = 'Unknown';
  String wallpaperUrlBoth = 'Unknown';
  String liveWallpaper = 'Unknown';
  String url =
      'https://e0.pxfuel.com/wallpapers/370/286/desktop-wallpaper-couple-love-heart-sunset-graphy-ss-love-couple.jpg';

  late bool goToHome;

  @override
  void initState() {
    super.initState();
    goToHome = false;
    initPlatformState();
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

  Future<void> setWallpaperFromFileHome() async {
    setState(() {
      wallpaperFileHome = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;

    setState(() {
      wallpaperFileHome = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset(
              widget.imgURL,
              fit: BoxFit.fill,
              height: double.infinity,
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
                            onTap: () {
                              setWallpaperFromFileHome;
                              if (wallpaperFileHome == 'Loading') {
                                showAltDialog(
                                  context,
                                  message:
                                      'Wallpapers Is Set As Home Screen Successfully.',
                                );
                              }
                            },
                            child: Text(
                              'Set as Lock Screen',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.05.sh),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showAltDialog(
                                context,
                                message:
                                    'Wallpapers Is Set As Home Screen Successfully.',
                              );
                            },
                            child: Text(
                              'Set as Home Screen',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.04.sh),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showAltDialog(
                                context,
                                message:
                                    'Wallpapers Is Set As Both Screen Successfully.',
                              );
                            },
                            child: Text(
                              'Set as Both',
                              textAlign: TextAlign.justify,
                              style: myTheme.textTheme.labelMedium,
                            ),
                          ),
                          verticalSpace(0.04.sh),
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

showAltDialog(
  BuildContext context, {
  String message = '',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: ColorManager.secondaryColor,
      iconPadding: padding(
        paddingType: PaddingType.LTRB,
        left: 0.04.sw,
        right: 0.04.sw,
      ),
      icon: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 0.05.sh,
          width: 0.1.sw,
          margin: margin(
            marginType: MarginType.top,
            marginValue: 0.01.sh,
          ),
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
      actionsPadding: padding(
        paddingType: PaddingType.all,
        paddingValue: 0.02.sh,
      ),
      titlePadding:
          padding(paddingType: PaddingType.top, paddingValue: 0.02.sh),
      title: Image.asset(
        ImageAssetManager.setWallpaperDone,
        height: 0.2.sh,
        width: 0.2.sw,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: myTheme.textTheme.titleMedium,
      ),
      elevation: 2,
      shadowColor: ColorManager.white,
      actions: [
        materialButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigationBarScreen(),
              ),
            );
          },
          buttonColor: const Color.fromRGBO(160, 152, 250, 1),
          buttonText: 'Back to home',
        ),
      ],
    ),
  );
}
