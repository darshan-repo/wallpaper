// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  List<String> likedWallpaper = [];
  final String userId = UserPreferences().getUserId();

  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured());
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

  @override
  Widget build(BuildContext context) {
    final userID = UserPreferences().getUserId();
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
              final data = BlocProvider.of<CollectionBlocBloc>(context)
                  .getFeaturedWallpaperModel!
                  .categories![index];
              final image = data.background!.split("/").last;
              return GestureDetector(
                onTap: () {
                  Get.to(
                    SetWallpaperScreen(
                      imgURL: BaseApi.imgUrl + image.toString(),
                      uploaded:
                          '${data.createdAt!.day.toString()}/${data.createdAt!.month.toString()}/${data.createdAt!.year.toString()}',
                    ),
                  );
                },
                child: cachedNetworkImage(
                  imageUrl: BaseApi.imgUrl + image,
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

                            BlocProvider.of<CollectionBlocBloc>(context).add(
                              SendDownloadWallpaper(
                                id: data.id ?? "",
                                userId: UserPreferences().getUserId(),
                                name: data.name ?? "",
                                category: data.name ?? "",
                                wallpaper: data.background ?? "",
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
                            if (!likedWallpaper.contains(data.id ?? "")) {
                              likedWallpaper.add(data.id ?? "");
                              BlocProvider.of<CollectionBlocBloc>(context).add(
                                SendLikedWallpaper(
                                  id: data.id ?? "",
                                  userId: UserPreferences().getUserId(),
                                  name: data.name ?? "",
                                  category: data.name ?? "",
                                  wallpaper: data.background ?? "",
                                ),
                              );
                              setState(() {});
                            } else {
                              likedWallpaper.remove(data.id ?? "");
                              BlocProvider.of<CollectionBlocBloc>(context).add(
                                SendDissLikeWallpaper(
                                  id: data.id ?? "",
                                  userId: UserPreferences().getUserId(),
                                ),
                              );
                              setState(() {});
                            }
                          }
                        },
                        child: SvgPicture.asset(
                          likedWallpaper.contains(data.id)
                              ? SVGIconManager.liked
                              : SVGIconManager.favorite,
                          color: likedWallpaper.contains(data.id)
                              ? ColorManager.red
                              : ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
