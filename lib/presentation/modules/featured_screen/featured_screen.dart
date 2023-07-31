// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  static const route = 'FeaturedScreen';

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  List<String> likedWallpaper = [];
  final String userId = UserPreferences.getUserId();

  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured(context));
    if (userId.isNotEmpty) {
      if (BlocProvider.of<CollectionBlocBloc>(context)
              .getLikedModel
              ?.likesData !=
          null) {
        for (int i = 0;
            i <
                BlocProvider.of<CollectionBlocBloc>(context)
                    .getLikedModel!
                    .likesData!
                    .length;
            i++) {
          setState(() {
            likedWallpaper.add(BlocProvider.of<CollectionBlocBloc>(context)
                    .getLikedModel
                    ?.likesData?[i]
                    .wallpaperId ??
                "");
          });
        }
      }
    }
    super.initState();
  }

  downloadAndSaveImageToGallery({required String imageUrl}) async {
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      var imageData = Uint8List.fromList(response.bodyBytes);
      await ImageGallerySaver.saveImage(
        imageData,
        quality: 1080,
        name: DateTime.now().toString(),
      );
    } else {
      log("Failed to load image: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userID = UserPreferences.getUserId();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(
        context,
      ),
      body: Padding(
        padding: padding(
          paddingType: PaddingType.all,
          paddingValue: 0.02.sh,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: BlocProvider.of<CollectionBlocBloc>(context)
                .getFeaturedWallpaperModel!
                .categories!
                .length,
            itemBuilder: (context, index) {
              final image = BlocProvider.of<CollectionBlocBloc>(context)
                  .getFeaturedWallpaperModel!
                  .categories![index]
                  .background!
                  .split("/")
                  .last;
              return CachedNetworkImage(
                imageUrl: BaseApi.imgUrl + image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageProvider,
                    ),
                  ),
                  alignment: Alignment.bottomRight,
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
                          GestureDetector(
                            onTap: () {
                              if (userID.isEmpty) {
                                Get.to(const LoginScreen());
                              } else {
                                downloadAndSaveImageToGallery(
                                    imageUrl: BaseApi.imgUrl + image);

                                BlocProvider.of<CollectionBlocBloc>(context)
                                    .add(
                                  SendDownloadWallpaper(
                                    id: BlocProvider.of<CollectionBlocBloc>(
                                                context)
                                            .getFeaturedWallpaperModel!
                                            .categories![index]
                                            .id ??
                                        "",
                                    userId: UserPreferences.getUserId(),
                                    name: BlocProvider.of<CollectionBlocBloc>(
                                                context)
                                            .getFeaturedWallpaperModel!
                                            .categories![index]
                                            .name ??
                                        "",
                                    category:
                                        BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .getFeaturedWallpaperModel!
                                                .categories![index]
                                                .name ??
                                            "",
                                    wallpaper:
                                        BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .getFeaturedWallpaperModel!
                                                .categories![index]
                                                .background ??
                                            "",
                                  ),
                                );
                                setState(() {});
                              }
                            },
                            child: SvgPicture.asset(
                              SVGIconManager.downloadWallpaper,
                              color: ColorManager.white,
                            ),
                          ),
                          verticalSpace(0.02.sh),
                          GestureDetector(
                            onTap: () {
                              if (userID.isEmpty) {
                                Get.to(const LoginScreen());
                              } else {
                                if (!likedWallpaper.contains(
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                            .getFeaturedWallpaperModel!
                                            .categories![index]
                                            .id ??
                                        "")) {
                                  likedWallpaper.add(
                                      BlocProvider.of<CollectionBlocBloc>(
                                                  context)
                                              .getFeaturedWallpaperModel!
                                              .categories![index]
                                              .id ??
                                          "");
                                  BlocProvider.of<CollectionBlocBloc>(context)
                                      .add(
                                    SendLikedWallpaper(
                                      id: BlocProvider.of<CollectionBlocBloc>(
                                                  context)
                                              .getFeaturedWallpaperModel!
                                              .categories![index]
                                              .id ??
                                          "",
                                      userId: UserPreferences.getUserId(),
                                      name: BlocProvider.of<CollectionBlocBloc>(
                                                  context)
                                              .getFeaturedWallpaperModel!
                                              .categories![index]
                                              .name ??
                                          "",
                                      category:
                                          BlocProvider.of<CollectionBlocBloc>(
                                                      context)
                                                  .getFeaturedWallpaperModel!
                                                  .categories![index]
                                                  .name ??
                                              "",
                                      wallpaper:
                                          BlocProvider.of<CollectionBlocBloc>(
                                                      context)
                                                  .getFeaturedWallpaperModel!
                                                  .categories![index]
                                                  .background ??
                                              "",
                                    ),
                                  );
                                  setState(() {});
                                } else {
                                  likedWallpaper.remove(
                                      BlocProvider.of<CollectionBlocBloc>(
                                                  context)
                                              .getFeaturedWallpaperModel!
                                              .categories![index]
                                              .id ??
                                          "");
                                  BlocProvider.of<CollectionBlocBloc>(context)
                                      .add(
                                    SendDissLikeWallpaper(
                                      id: BlocProvider.of<CollectionBlocBloc>(
                                                  context)
                                              .getFeaturedWallpaperModel!
                                              .categories![index]
                                              .id ??
                                          "",
                                      userId: UserPreferences.getUserId(),
                                    ),
                                  );
                                  setState(() {});
                                }
                              }
                            },
                            child: SvgPicture.asset(
                              likedWallpaper.contains(
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getFeaturedWallpaperModel!
                                          .categories![index]
                                          .id)
                                  ? SVGIconManager.liked
                                  : SVGIconManager.favorite,
                              color: likedWallpaper.contains(
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getFeaturedWallpaperModel!
                                          .categories![index]
                                          .id)
                                  ? ColorManager.red
                                  : ColorManager.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                    child: SpinKitCircle(color: ColorManager.white)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            },
          ),
        ),
      ),
    );
  }
}
