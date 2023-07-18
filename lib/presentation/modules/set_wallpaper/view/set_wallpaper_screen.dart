// ignore_for_file: use_build_context_synchronously

import 'package:wallpaper/libs.dart';

class SetWallpaperScreen extends StatefulWidget {
  final Map<String, dynamic> imgURL;
  const SetWallpaperScreen({super.key, required this.imgURL});
  static const route = 'SetWallpaperScreen';

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  String wallpaperUrlHome = 'Unknown';
  String wallpaperUrlLock = 'Unknown';
  String wallpaperUrlBoth = 'Unknown';
  bool isSelect = false;
  bool isLoading = false;
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

  Future<void> setHomeScreenWallpaper() async {
    setState(() {
      isLoading = true;
      wallpaperUrlHome = 'Loading';
    });
    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: widget.imgURL['img'],
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
      wallpaperUrlHome = result;
    });
  }

  Future<void> setLockScreenWallpaper() async {
    setState(() {
      isLoading = true;
      wallpaperUrlLock = 'Loading';
    });
    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: widget.imgURL['img'],
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;

    setState(() {
      isLoading = false;
      wallpaperUrlLock = result;
    });
  }

  Future<void> setBothScreenWallpaper() async {
    setState(() {
      isLoading = true;
      wallpaperUrlBoth = 'Loading';
    });
    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: widget.imgURL['img'],
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;

    setState(() {
      isLoading = false;
      wallpaperUrlBoth = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              widget.imgURL['img'],
              fit: BoxFit.fill,
              height: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    height: 0.05.sh,
                    width: 0.115.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorManager.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.info_outline,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: padding(
                paddingType: PaddingType.LTRB,
                left: 0.02.sw,
                right: 0.03.sw,
                bottom: 0.18.sh,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelect = !isSelect;
                      });
                    },
                    child: isSelect
                        ? Icon(
                            Icons.favorite_rounded,
                            size: 0.04.sh,
                            color: ColorManager.red,
                          )
                        : Icon(
                            Icons.favorite_border_rounded,
                            size: 0.04.sh,
                            color: ColorManager.white,
                          ),
                  ),
                  verticalSpace(0.03.sh),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.file_download_outlined,
                      size: 0.04.sh,
                      color: ColorManager.white,
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
                              await setLockScreenWallpaper();
                              Navigator.pop(context);
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : showAltDialog(
                                      context,
                                      message:
                                          'Wallpapers Is Set As Lock Screen Successfully.',
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
                              await setHomeScreenWallpaper();
                              Navigator.pop(context);
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : showAltDialog(
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
                          verticalSpace(0.05.sh),
                          GestureDetector(
                            onTap: () async {
                              await setBothScreenWallpaper();
                              Navigator.pop(context);
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : showAltDialog(
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
