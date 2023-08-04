// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

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
  final String userId = UserPreferences.getUserId();

  @override
  void initState() {
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
    String userID = UserPreferences.getUserId();
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(context),
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
            widget.categoriesData!.isEmpty
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
                          'Oops ! No Wallpaper found!',
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
                                      '${widget.categoriesData?[index].createdAt!.day.toString()}/${widget.categoriesData?[index].createdAt!.month.toString()}/${widget.categoriesData?[index].createdAt!.year.toString()}',
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
                                    fit: BoxFit.cover,
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
                                                  imageUrl:
                                                      BaseApi.imgUrl + image);
                                              BlocProvider.of<
                                                          CollectionBlocBloc>(
                                                      context)
                                                  .add(
                                                SendDownloadWallpaper(
                                                  id: widget
                                                          .categoriesData?[
                                                              index]
                                                          .id ??
                                                      "",
                                                  userId: UserPreferences
                                                      .getUserId(),
                                                  name: widget
                                                          .categoriesData?[
                                                              index]
                                                          .name ??
                                                      "",
                                                  category: widget
                                                          .categoriesData?[
                                                              index]
                                                          .category ??
                                                      "",
                                                  wallpaper: widget
                                                          .categoriesData?[
                                                              index]
                                                          .wallpaper ??
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
                                                  widget.categoriesData?[index]
                                                          .id ??
                                                      "")) {
                                                likedWallpaper.add(widget
                                                        .categoriesData?[index]
                                                        .id ??
                                                    "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendLikedWallpaper(
                                                    id: widget
                                                            .categoriesData?[
                                                                index]
                                                            .id ??
                                                        "",
                                                    userId: UserPreferences
                                                        .getUserId(),
                                                    name: widget
                                                            .categoriesData?[
                                                                index]
                                                            .name ??
                                                        "",
                                                    category: widget
                                                            .categoriesData?[
                                                                index]
                                                            .category ??
                                                        "",
                                                    wallpaper: widget
                                                            .categoriesData?[
                                                                index]
                                                            .wallpaper ??
                                                        "",
                                                  ),
                                                );
                                                setState(() {});
                                              } else {
                                                likedWallpaper.remove(widget
                                                        .categoriesData?[index]
                                                        .id ??
                                                    "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendDissLikeWallpaper(
                                                    id: widget
                                                            .categoriesData?[
                                                                index]
                                                            .id ??
                                                        "",
                                                    userId: UserPreferences
                                                        .getUserId(),
                                                  ),
                                                );
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            likedWallpaper.contains(widget
                                                    .categoriesData?[index].id)
                                                ? SVGIconManager.liked
                                                : SVGIconManager.favorite,
                                            color: likedWallpaper.contains(
                                                    widget
                                                        .categoriesData?[index]
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
                                child: SpinKitCircle(color: ColorManager.white),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: ColorManager.white),
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
