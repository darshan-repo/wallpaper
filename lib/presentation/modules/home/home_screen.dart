// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

class HomeScreenInit extends StatelessWidget {
  const HomeScreenInit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaginationBloc>(
      create: (context) => PaginationBloc()..add(PaginationInitialEvent()),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List items = [
    'Recent',
    'Trending',
    'Exclusive',
  ];

  String selectedValue = 'Exclusive';
  bool isSelectGrid = true;

  List<String> likedWallpaper = [];
  final String userId = UserPreferences.getUserId();

  late final PaginationBloc paginationBloc;

  // List<Trending> trendingWallpaper = [];
  // List<Wallpaper> recentWallpaper = [];
  // List<Wallpaper> exclusiveWallpaper = [];
  //
  // void sortingWallpaper(String values) async {
  //   debugPrint('======== Sorting Wallpaper Called ========');
  //   if (values == 'Recent') {
  //     recentWallpaper.clear();
  //     for (int i =
  //             BlocProvider.of<PaginationBloc>(context).allWallpaper!.length - 1;
  //         i >= 0;
  //         i--) {
  //       setState(() {
  //         recentWallpaper
  //             .add(BlocProvider.of<PaginationBloc>(context).allWallpaper![i]);
  //       });
  //     }
  //     log('=================>> Recent ${recentWallpaper.length}');
  //   } else if (values == "Trending") {
  //     trendingWallpaper.clear();
  //     for (int i = 0;
  //         i <
  //             (BlocProvider.of<CollectionBlocBloc>(context)
  //                     .getTrendingWallpaperModel
  //                     ?.trending
  //                     ?.length ??
  //                 0);
  //         i++) {
  //       setState(() {
  //         trendingWallpaper.add(BlocProvider.of<CollectionBlocBloc>(context)
  //             .getTrendingWallpaperModel!
  //             .trending![i]);
  //       });
  //     }
  //
  //     log('=================>> Trending ${trendingWallpaper.length}');
  //   } else if (values == "Exclusive") {
  //     exclusiveWallpaper.clear();
  //     setState(() {
  //       for (int i = 0;
  //           i <
  //               (BlocProvider.of<PaginationBloc>(context)
  //                       .allWallpaper
  //                       ?.length ??
  //                   0);
  //           i++) {
  //         setState(() {
  //           exclusiveWallpaper
  //               .add(BlocProvider.of<PaginationBloc>(context).allWallpaper![i]);
  //         });
  //       }
  //       log('=================>> Exclusive ${exclusiveWallpaper.length}');
  //     });
  //   }
  // }

  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured());
    BlocProvider.of<PaginationBloc>(context).add(GetPaginationDataEvent());
    // BlocProvider.of<CollectionBlocBloc>(context).add(GetTrendingWallpaper());
    // sortingWallpaper('Exclusive');
    paginationBloc = BlocProvider.of<PaginationBloc>(context);
    try {
      scrollController = ScrollController();
      scrollController?.addListener(() async {
        if (scrollController!.offset >=
                scrollController!.position.maxScrollExtent &&
            !scrollController!.position.outOfRange) {
          paginationBloc.add(GetPaginationDataEvent());
        }
      });
    } catch (e, s) {
      debugPrint("ERROR :: $e");
      debugPrint("STACK :: $s");
    }
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
      setState(() {});
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
      log("Failed to load image : ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userID = UserPreferences.getUserId();
    final image1 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![0]
            .background!
            .split("/")
            .last ??
        "";
    final image2 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![1]
            .background!
            .split("/")
            .last ??
        "";
    final image3 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![2]
            .background!
            .split("/")
            .last ??
        "";
    final image4 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![3]
            .background!
            .split("/")
            .last ??
        "";

    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: BlocConsumer<PaginationBloc, PaginationState>(
          bloc: paginationBloc,
          listener: (BuildContext context, PaginationState state) {
            if (state is SnackbarEvent) {
              errorSnackbar(state.message);
            }
          },
          buildWhen: (previous, current) => current is UserListRefreshState,
          builder: (context, state) => CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leadingWidth: 0.0,
                leading: const Text(''),
                expandedHeight: 0.45.sh,
                floating: true,
                pinned: true,
                backgroundColor: ColorManager.primaryColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
                    builder: (BuildContext context, CollectionBlocState state) {
                      if (state is CollectionLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Featured.',
                              style: myTheme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                            verticalSpace(0.01.sh),
                            conatiner(
                              context,
                              height: 0.2,
                              width: double.infinity,
                              assetName: BaseApi.imgUrl + image1.toString(),
                            ),
                            verticalSpace(0.009.sh),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                conatiner(
                                  context,
                                  assetName: BaseApi.imgUrl + image2.toString(),
                                ),
                                conatiner(
                                  context,
                                  assetName: BaseApi.imgUrl + image3.toString(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const FeaturedScreen());
                                  },
                                  child: conatiner(
                                    context,
                                    assetName:
                                        BaseApi.imgUrl + image4.toString(),
                                    child: Container(
                                      height: 0.1.sh,
                                      width: 0.30.sh,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Text(
                                        '+ ${BlocProvider.of<CollectionBlocBloc>(context).getFeaturedWallpaperModel?.categories!.length}',
                                        style: myTheme.textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  title: Container(
                    width: double.infinity,
                    padding: padding(
                        paddingType: PaddingType.vertical,
                        paddingValue: 0.01.sh),
                    color: ColorManager.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dropDownButton(
                          selectedValue: selectedValue,
                          items: items
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: myTheme.textTheme.titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                              // sortingWallpaper(selectedValue);
                            });
                          },
                        ),
                        // const Spacer(),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => const FilterScreen());
                        //   },
                        //   child: Container(
                        //     height: 0.05.sh,
                        //     width: 0.115.sw,
                        //     margin: margin(
                        //       marginType: MarginType.LTRB,
                        //       right: 0.04.sw,
                        //     ),
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       color: ColorManager.secondaryColor,
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: SvgPicture.asset(
                        //       SVGIconManager.filter,
                        //       color: ColorManager.white,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          padding: padding(
                            paddingType: PaddingType.LTRB,
                            left: 0.015.sw,
                            right: 0.015.sw,
                          ),
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                            color: ColorManager.secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelectGrid = true;
                                  });
                                },
                                child: Container(
                                  padding: padding(
                                      paddingType: PaddingType.all,
                                      paddingValue: 0.003.sh),
                                  width: 0.085.sw,
                                  height: 0.04.sh,
                                  decoration: BoxDecoration(
                                    color: isSelectGrid
                                        ? const Color.fromRGBO(160, 152, 250, 1)
                                        : ColorManager.primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: SvgPicture.asset(
                                    SVGIconManager.gridCollection,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ),
                              horizontalSpace(0.02.sw),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelectGrid = false;
                                  });
                                },
                                child: Container(
                                  padding: padding(
                                    paddingType: PaddingType.all,
                                    paddingValue: 0.003.sh,
                                  ),
                                  width: 0.085.sw,
                                  height: 0.04.sh,
                                  decoration: BoxDecoration(
                                    color: isSelectGrid
                                        ? ColorManager.primaryColor
                                        : const Color.fromRGBO(
                                            160, 152, 250, 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: SvgPicture.asset(
                                    SVGIconManager.collection,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandedTitleScale: 1,
                  titlePadding: const EdgeInsets.all(0),
                ),
              ),
              isSelectGrid
                  ? SliverMasonryGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,

                      childCount: BlocProvider.of<PaginationBloc>(context)
                          .allWallpaper
                          ?.length,
                      // childCount:
                      // selectedValue == "Recent"
                      //     ? recentWallpaper.length
                      //     : selectedValue == "Trending"
                      //         ? trendingWallpaper.length
                      //         : exclusiveWallpaper.length,
                      itemBuilder: (context, index) {
                        final data = BlocProvider.of<PaginationBloc>(context)
                            .allWallpaper?[index];
                        // final data;
                        // if (selectedValue == "Recent") {
                        //   data = recentWallpaper[index];
                        // } else if (selectedValue == "Trending") {
                        //   data = trendingWallpaper[index];
                        // } else {
                        //   data = exclusiveWallpaper[index];
                        // }
                        final image = data?.wallpaper!.split("/").last;

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              SetWallpaperScreen(
                                imgURL: BaseApi.imgUrl + image.toString(),
                                uploaded:
                                    '${data?.createdAt!.day.toString()}/${data?.createdAt!.month.toString()}/${data?.createdAt!.year.toString()}',
                              ),
                            );
                          },
                          child: SizedBox(
                            height: (index % 5 + 1) * 100,
                            child: CachedNetworkImage(
                              cacheKey: BaseApi.imgUrl + image.toString(),
                              imageUrl: BaseApi.imgUrl + image.toString(),
                              memCacheHeight: 10,
                              memCacheWidth: 10,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.secondaryColor,
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
                                          onTap: () async {
                                            if (userID.isEmpty) {
                                              Get.to(const LoginScreen());
                                            } else {
                                              downloadAndSaveImageToGallery(
                                                  imageUrl:
                                                      BaseApi.imgUrl + image!);
                                              BlocProvider.of<
                                                          CollectionBlocBloc>(
                                                      context)
                                                  .add(
                                                SendDownloadWallpaper(
                                                  id: data?.id ?? "",
                                                  userId: UserPreferences
                                                      .getUserId(),
                                                  name: data?.name ?? "",
                                                  category:
                                                      data?.category ?? "",
                                                  wallpaper:
                                                      data?.wallpaper ?? "",
                                                ),
                                              );
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
                                              if (!likedWallpaper
                                                  .contains(data?.id ?? "")) {
                                                likedWallpaper
                                                    .add(data?.id ?? "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendLikedWallpaper(
                                                    id: data?.id ?? "",
                                                    userId: UserPreferences
                                                        .getUserId(),
                                                    name: data?.name ?? "",
                                                    category:
                                                        data?.category ?? "",
                                                    wallpaper:
                                                        data?.wallpaper ?? "",
                                                  ),
                                                );
                                                setState(() {});
                                              } else {
                                                likedWallpaper
                                                    .remove(data?.id ?? "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendDissLikeWallpaper(
                                                    id: data?.id ?? "",
                                                    userId: UserPreferences
                                                        .getUserId(),
                                                  ),
                                                );
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            !likedWallpaper.contains(data?.id)
                                                ? SVGIconManager.liked
                                                : SVGIconManager.favorite,
                                            color: !likedWallpaper
                                                    .contains(data?.id)
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    )
                  : NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          childCount: BlocProvider.of<PaginationBloc>(context)
                              .allWallpaper
                              ?.length,

                          // childCount: selectedValue == "Recent"
                          //     ? recentWallpaper.length
                          //     : selectedValue == "Trending"
                          //     ? trendingWallpaper.length
                          //     : selectedValue == "Exclusive"
                          //     ? exclusiveWallpaper.length
                          //     : 0,
                          (context, index) {
                            final data =
                                BlocProvider.of<PaginationBloc>(context)
                                    .allWallpaper?[index];
                            // if (selectedValue == "Recent") {
                            //   data = recentWallpaper[index];
                            // } else if (selectedValue == "Trending") {
                            //   data = trendingWallpaper[index];
                            // } else {
                            //   data = exclusiveWallpaper[index];
                            // }

                            final image = data?.wallpaper?.split("/").last;
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  SetWallpaperScreen(
                                    imgURL: BaseApi.imgUrl + image.toString(),
                                    uploaded:
                                        '${data?.createdAt!.day.toString()}/${data?.createdAt!.month.toString()}/${data?.createdAt!.year.toString()}',
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: BaseApi.imgUrl + image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                    id: data?.id ?? "",
                                                    userId: UserPreferences
                                                        .getUserId(),
                                                    name: data?.name ?? "",
                                                    category:
                                                        data?.category ?? "",
                                                    wallpaper:
                                                        data?.wallpaper ?? "",
                                                  ),
                                                );
                                                successSnackbar(
                                                    'wallpaper successfully downloaded!');
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
                                                if (!likedWallpaper
                                                    .contains(data?.id ?? "")) {
                                                  likedWallpaper
                                                      .add(data?.id ?? "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendLikedWallpaper(
                                                      id: data?.id ?? "",
                                                      userId: UserPreferences
                                                          .getUserId(),
                                                      name: data?.name ?? "",
                                                      category:
                                                          data?.category ?? "",
                                                      wallpaper:
                                                          data?.wallpaper ?? "",
                                                    ),
                                                  );
                                                  setState(() {});
                                                } else {
                                                  likedWallpaper
                                                      .remove(data?.id ?? "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendDissLikeWallpaper(
                                                      id: data?.id ?? "",
                                                      userId: UserPreferences
                                                          .getUserId(),
                                                    ),
                                                  );
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              !likedWallpaper
                                                      .contains(data?.id ?? "")
                                                  ? SVGIconManager.liked
                                                  : SVGIconManager.favorite,
                                              color: !likedWallpaper
                                                      .contains(data?.id ?? "")
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
                                  child:
                                      SpinKitCircle(color: ColorManager.white),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
