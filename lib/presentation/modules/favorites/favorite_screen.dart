// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

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

  downloadAndSaveImageToGallery({required String imageUrl}) async {
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      var imageData = Uint8List.fromList(response.bodyBytes);
      await ImageGallerySaver.saveImage(
        imageData,
        quality: 60,
        name: DateTime.now().toString(),
      );
    } else {
      log("Failed to load image: ${response.statusCode}");
    }
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
          actionIcon: Icons.filter_alt_outlined,
          actionOnTap: () {
            Get.to(const FilterScreen());
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
                            'Oops ! No favorites to display',
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
                            return CachedNetworkImage(
                              imageUrl: BaseApi.imgUrl + image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                        bottom: 0.01.sh),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            downloadAndSaveImageToGallery(
                                                imageUrl:
                                                    BaseApi.imgUrl + image);
                                            BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .add(
                                              SendDownloadWallpaper(
                                                id: favouriteList[index].id ??
                                                    "",
                                                userId:
                                                    UserPreferences.getUserId(),
                                                name:
                                                    favouriteList[index].name ??
                                                        "",
                                                category: favouriteList[index]
                                                        .category ??
                                                    "",
                                                wallpaper: favouriteList[index]
                                                        .wallpaper ??
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
                                                userId:
                                                    UserPreferences.getUserId(),
                                              ),
                                            );
                                            favouriteList.removeAt(index);
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              SVGIconManager.liked,
                                              color: ColorManager.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: SpinKitCircle(color: ColorManager.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
