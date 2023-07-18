import 'package:wallpaper/libs.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static const route = 'FavoriteScreen';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
                'Favorites',
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
                            'Oops ! No favorites to display',
                            style: TextStyle(
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.roboto,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeightManager.semiBold,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color(0xffA098FA),
                                    Color.fromARGB(255, 141, 82, 77),
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
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      ImageJPGManager.yellowPinkColor),
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
                                      Icon(
                                        Icons.file_download_outlined,
                                        size: 0.035.sh,
                                        color: ColorManager.white,
                                      ),
                                      verticalSpace(0.02.sh),
                                      Icon(
                                        Icons.favorite_rounded,
                                        size: 0.035.sh,
                                        color: ColorManager.red,
                                      ),
                                    ],
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
