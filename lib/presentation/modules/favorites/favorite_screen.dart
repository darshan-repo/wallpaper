// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<LikesDatum> favouriteList = [];

  @override
  void initState() {
    if (favouriteList.isNotEmpty) {
      favouriteList.clear();
    }

    if (BlocProvider.of<CollectionBlocBloc>(context).getLikedModel != null) {
      BlocProvider.of<CollectionBlocBloc>(context)
          .getLikedModel!
          .likesData!
          .map((e) {
        favouriteList.add(e);
      }).toList(growable: true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(
          context,
          leadingOnTap: () {
            Get.off(const BottomNavigationBarScreen());
          },
        ),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.favorites,
                style: myTheme.textTheme.titleLarge,
              ),
              verticalSpace(0.01.sh),
              Text(
                AppString.favoritesDesc,
                style: myTheme.textTheme.labelMedium,
              ),
              verticalSpace(0.01.sh),
              favouriteList.isEmpty
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
                            AppString.oopsNoFavoritesToDisplay,
                            style: TextStyle(
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.roboto,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeightManager.semiBold,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(160, 152, 250, 1),
                                    Color.fromRGBO(141, 82, 77, 1),
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
                          itemCount: favouriteList.length,
                          itemBuilder: (context, index) {
                            final image =
                                favouriteList[index].wallpaper?.split("/").last;
                            return cachedNetworkImage(
                              imageUrl: BaseApi.imgUrl + image!,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      downloadAndSaveImageToGallery(
                                          imageUrl: BaseApi.imgUrl + image);
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .add(
                                        SendDownloadWallpaper(
                                          id: favouriteList[index].id ?? "",
                                          userId: UserPreferences().getUserId(),
                                          name: favouriteList[index].name ?? "",
                                          category:
                                              favouriteList[index].category ??
                                                  "",
                                          wallpaper:
                                              favouriteList[index].wallpaper ??
                                                  "",
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.file_download_outlined,
                                      size: 0.035.sh,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  verticalSpace(0.02.sh),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .add(
                                        SendDissLikeWallpaper(
                                          id: favouriteList[index]
                                                  .wallpaperId ??
                                              "",
                                          userId: UserPreferences().getUserId(),
                                        ),
                                      );
                                      favouriteList.removeAt(index);
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      SVGIconManager.liked,
                                      color: ColorManager.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
