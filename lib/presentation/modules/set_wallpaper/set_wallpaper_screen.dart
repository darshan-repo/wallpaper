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

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await AsyncWallpaper.platformVersion ??
          AppString.unknownPlatformVersion;
    } on PlatformException {
      platformVersion = AppString.failedToGetPlatformVersion;
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
          ? AppString.wallpaperSet
          : AppString.failedToGetWallpaper;
    } on PlatformException {
      AppString.failedToGetWallpaper;
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
          ? AppString.wallpaperSet
          : AppString.failedToGetWallpaper;
    } on PlatformException {
      AppString.failedToGetWallpaper;
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
          ? AppString.wallpaperSet
          : AppString.failedToGetWallpaper;
    } on PlatformException {
      AppString.failedToGetWallpaper;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userId = UserPreferences().getUserId();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImageBuilder(
              url: widget.imgURL,
              builder: (image) => Image.file(
                image,
                fit: BoxFit.cover,
              ),
              placeHolder: const CustomLoader(),
              errorWidget: const Icon(Icons.error),
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
                  if (userId.isEmpty) {
                    Get.to(() => const LoginScreen());
                  } else {
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
                            paddingType: PaddingType.all,
                            paddingValue: 0.02.sh),
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
                                  message: AppString
                                      .wallpaperIsSetAsLockScreenSuccessfully,
                                );
                              },
                              child: Text(
                                AppString.setAsLockScreen,
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
                                  message: AppString
                                      .wallpaperIsSetAsHomeScreenSuccessfully,
                                );
                              },
                              child: Text(
                                AppString.setAsHomeScreen,
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
                                  message: AppString
                                      .wallpaperIsSetAsBothScreenSuccessfully,
                                );
                              },
                              child: Text(
                                AppString.setAsBoth,
                                textAlign: TextAlign.justify,
                                style: myTheme.textTheme.labelMedium,
                              ),
                            ),
                            verticalSpace(0.05.sh),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ReportAnIssueScreen());
                              },
                              child: Text(
                                AppString.reportThisPhoto,
                                textAlign: TextAlign.justify,
                                style: myTheme.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                buttonText: AppString.apply,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
