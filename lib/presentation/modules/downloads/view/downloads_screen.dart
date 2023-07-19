import 'package:wallpaper/libs.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});
  static const route = 'DownloadScreen';

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(
          context,
          leadingOnTap: () {
            AppNavigation.shared.moveToBottomNavigationBarScreen();
          },
          actionIcon: Icons.filter_alt_outlined,
          actionOnTap: () {
            AppNavigation.shared.moveToFilterScreen();
          },
        ),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Downloads',
                style: myTheme.textTheme.titleLarge,
              ),
              verticalSpace(0.01.sh),
              Text(
                'You\'ve marked all of these as a favorite!',
                style: myTheme.textTheme.labelMedium,
              ),
              verticalSpace(0.01.sh),
              isShow
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            ImageSVGManager.noDataFound,
                            height: 0.5.sh,
                            width: 0.5.sw,
                          ),
                          Text(
                            'Oops ! No downloads to display',
                            style: TextStyle(
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.roboto,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeightManager.semiBold,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(160, 152, 250, 1),
                                    Color.fromRGBO(175, 117, 112, 1),
                                    Colors.yellow
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(100.0, 0.0, 180.0, 70.0),
                                ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
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
                                    height: 400,
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
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Downloads',
                                          style: myTheme.textTheme.titleLarge,
                                        ),
                                        verticalSpace(0.05.sh),
                                        bottomContent(
                                          assetName: ImageAssetManager.favorite,
                                          title: 'Save to my favorite',
                                        ),
                                        verticalSpace(0.04.sh),
                                        GestureDetector(
                                          onLongPress: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    ColorManager.secondaryColor,
                                                icon: Container(
                                                  margin: margin(
                                                      marginType:
                                                          MarginType.horizontal,
                                                      marginValue: 0.15.sw),
                                                  height: 0.15.sh,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    image:
                                                        const DecorationImage(
                                                      image: AssetImage(
                                                        ImageJPGManager
                                                            .yellowPinkColor,
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                  'Remove item?',
                                                  textAlign: TextAlign.center,
                                                  style: myTheme
                                                      .textTheme.titleMedium,
                                                ),
                                                content: Text(
                                                  'Are you sure want to remove this item?',
                                                  textAlign: TextAlign.center,
                                                  style: myTheme
                                                      .textTheme.headlineSmall,
                                                ),
                                                elevation: 2,
                                                shadowColor: ColorManager.white,
                                                actions: [
                                                  materialButton(
                                                    onPressed: () {},
                                                    buttonColor:
                                                        const Color.fromRGBO(
                                                            160, 152, 250, 1),
                                                    buttonText: 'Sure',
                                                  ),
                                                  verticalSpace(0.03.sh),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'No, thanks',
                                                        style: myTheme.textTheme
                                                            .displaySmall,
                                                      ),
                                                    ),
                                                  ),
                                                  verticalSpace(0.02.sh),
                                                ],
                                              ),
                                            );
                                          },
                                          child: bottomContent(
                                            assetName: ImageAssetManager.delete,
                                            title: 'Delete',
                                          ),
                                        ),
                                        verticalSpace(0.04.sh),
                                        bottomContent(
                                          assetName: ImageAssetManager.share,
                                          title: 'Share',
                                        ),
                                        verticalSpace(0.04.sh),
                                        bottomContent(
                                          assetName:
                                              ImageAssetManager.reportAnIssue,
                                          title: 'Report this',
                                        ),
                                        verticalSpace(0.02.sh),
                                        const Divider(
                                          color: ColorManager.primaryColor,
                                        ),
                                        materialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          buttonColor: const Color.fromRGBO(
                                              255, 128, 147, 1),
                                          buttonText: 'Cancle',
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      ImageJPGManager.yellowPinkColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
