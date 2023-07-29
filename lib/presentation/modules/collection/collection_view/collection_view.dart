// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

class CollectionViewScreen extends StatefulWidget {
  final List<CategoryData>? categoriesData;
  final String categoryName;

  const CollectionViewScreen(
      {super.key, required this.categoriesData, required this.categoryName});

  @override
  State<CollectionViewScreen> createState() => _CollectionViewScreenState();
}

class _CollectionViewScreenState extends State<CollectionViewScreen> {
  List<String> likedWallpaper = [];
  List<String> downloadWallpaper = [];
  final String userId = UserPreferences.getUserId();

  @override
  void initState() {
    if (userId.isNotEmpty) {
      if (BlocProvider
          .of<CollectionBlocBloc>(context)
          .getDownloadModel
          ?.downloadData !=
          null) {
        for (int i = 0;
        i <
            BlocProvider
                .of<CollectionBlocBloc>(context)
                .getDownloadModel!
                .downloadData!
                .length;
        i++) {
          setState(() {
            downloadWallpaper.add(BlocProvider
                .of<CollectionBlocBloc>(context)
                .getDownloadModel
                ?.downloadData?[i]
                .wallpaperId ??
                "");
          });
        }
      }
      if (BlocProvider
          .of<CollectionBlocBloc>(context)
          .getLikedModel
          ?.likesData !=
          null) {
        for (int i = 0;
        i <
            BlocProvider
                .of<CollectionBlocBloc>(context)
                .getLikedModel!
                .likesData!
                .length;
        i++) {
          setState(() {
            likedWallpaper.add(BlocProvider
                .of<CollectionBlocBloc>(context)
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
        quality: 60,
        name: DateTime.now().toString(),
      );
    } else {
      log("Failed to load image: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userID = UserPreferences.getUserId();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(context, actionIcon: Icons.filter_alt_outlined,
          actionOnTap: () {
            Get.to(const FilterScreen());
          }),
      body: Padding(
        padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryName,
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.01.sh),
            Text(
              "${widget.categoriesData?.length} Wallpaper",
              style: myTheme.textTheme.labelMedium,
            ),
            verticalSpace(0.01.sh),
            Expanded(
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
                  itemCount: widget.categoriesData?.length,
                  itemBuilder: (context, index) {
                    final image = widget.categoriesData?[index].wallpaper!
                        .split("/")
                        .last;
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          SetWallpaperScreen(
                            imgURL: BaseApi.imgUrl + image.toString(),
                            uploaded:
                            '${widget.categoriesData?[index].createdAt!.day
                                .toString()}/${widget.categoriesData?[index]
                                .createdAt!.month.toString()}/${widget
                                .categoriesData?[index]
                                .createdAt!.year.toString()}',
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: BaseApi.imgUrl + image!,
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorManager.secondaryColor,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
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
                                    bottom: 0.005.sh,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (userID.isEmpty) {
                                            Get.to(const LoginScreen());
                                          } else {
                                            downloadAndSaveImageToGallery(
                                                imageUrl: BaseApi.imgUrl +
                                                    image);
                                            if (!downloadWallpaper.contains(
                                                widget.categoriesData?[index]
                                                    .id)) {
                                              downloadWallpaper.add(widget
                                                  .categoriesData?[index].id ??
                                                  "");
                                              BlocProvider.of<
                                                  CollectionBlocBloc>(
                                                  context)
                                                  .add(
                                                SendDownloadWallpaper(
                                                  id: widget
                                                      .categoriesData?[index]
                                                      .id ??
                                                      "",
                                                  userId:
                                                  UserPreferences.getUserId(),
                                                  name: widget
                                                      .categoriesData?[index]
                                                      .name ??
                                                      "",
                                                  category: widget
                                                      .categoriesData?[index]
                                                      .category ??
                                                      "",
                                                  wallpaper: widget
                                                      .categoriesData?[index]
                                                      .wallpaper ??
                                                      "",
                                                ),
                                              );
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          downloadWallpaper.contains(
                                              widget.categoriesData?[index].id)
                                              ? SVGIconManager.done
                                              : SVGIconManager
                                              .downloadWallpaper,
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
                                                widget.categoriesData?[index]
                                                    .id ??
                                                    "")) {
                                              likedWallpaper.add(widget
                                                  .categoriesData?[index].id ??
                                                  "");
                                              BlocProvider.of<
                                                  CollectionBlocBloc>(
                                                  context)
                                                  .add(
                                                SendLikedWallpaper(
                                                  id: widget
                                                      .categoriesData?[index]
                                                      .id ??
                                                      "",
                                                  userId:
                                                  UserPreferences.getUserId(),
                                                  name: widget
                                                      .categoriesData?[index]
                                                      .name ??
                                                      "",
                                                  category: widget
                                                      .categoriesData?[index]
                                                      .category ??
                                                      "",
                                                  wallpaper: widget
                                                      .categoriesData?[index]
                                                      .wallpaper ??
                                                      "",
                                                ),
                                              );
                                              setState(() {});
                                            } else {
                                              likedWallpaper.remove(widget
                                                  .categoriesData?[index].id ??
                                                  "");
                                              BlocProvider.of<
                                                  CollectionBlocBloc>(
                                                  context)
                                                  .add(
                                                SendDissLikeWallpaper(
                                                  id: widget
                                                      .categoriesData?[index]
                                                      .id ??
                                                      "",
                                                  userId:
                                                  UserPreferences.getUserId(),
                                                ),
                                              );
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          likedWallpaper.contains(
                                              widget.categoriesData?[index].id)
                                              ? SVGIconManager.liked
                                              : SVGIconManager.favorite,
                                          color: likedWallpaper.contains(
                                              widget.categoriesData?[index].id)
                                              ? ColorManager.red
                                              : ColorManager.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        placeholder: (context, url) =>
                        const Center(
                          child: SpinKitCircle(color: ColorManager.white),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: ColorManager.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
