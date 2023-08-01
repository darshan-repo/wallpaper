// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;
import 'package:walper/logic/pagination/pagination_bloc.dart';
import 'package:walper/logic/pagination/pagination_event.dart';
import 'package:walper/logic/pagination/pagination_state.dart';

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

  //
  // List<Wallpaper> trendingWallpaper = [];
  // List<Wallpaper> recentWallpaper = [];
  // List<Wallpaper> exclusiveWallpaper = [];

  // sortingWallpaper(String values) async {
  //   if (values == 'Recent') {
  //     setState(() {
  //       for (int i =
  //               BlocProvider.of<PaginationBloc>(context).allWallpaper!.length -
  //                   1;
  //           i > 0;
  //           i--) {
  //         setState(() {
  //           recentWallpaper
  //               .add(BlocProvider.of<PaginationBloc>(context).allWallpaper![i]);
  //         });
  //       }
  //     });
  //   } else if (values == "Trending") {
  //     trendingWallpaper.clear();
  //     recentWallpaper.clear();
  //   } else if (values == "Exclusive") {
  //     log(" ::::::::::::::::::     CALLED EXCLUSIVE        ::::::::::::::::: ");
  //     exclusiveWallpaper.clear();
  //     for (int i = 0;
  //         i <
  //             (BlocProvider.of<PaginationBloc>(context).allWallpaper?.length ??
  //                 0);
  //         i++) {
  //       setState(() {
  //         exclusiveWallpaper
  //             .add(BlocProvider.of<PaginationBloc>(context).allWallpaper![i]);
  //       });
  //     }
  //     // log('wallpaper.length :::::::: ${BlocProvider.of<PaginationBloc>(context).allWallpaper!.length}');
  //     setState(() {});
  //   }
  // }

  late final PaginationBloc paginationBloc;

  @override
  void initState() {
    BlocProvider.of<PaginationBloc>(context).add(GetPaginationDataEvent());
    // BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured());
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

    // sortingWallpaper("Exclusive");
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
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured.',
                        style: myTheme.textTheme.titleLarge,
                      ),
                      verticalSpace(0.01.sh),
                      conatiner(
                        height: 0.2,
                        width: double.infinity,
                        assetName: BaseApi.imgUrl + image1,
                      ),
                      verticalSpace(0.009.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          conatiner(
                            height: 0.1,
                            width: 0.30,
                            assetName: BaseApi.imgUrl + image2,
                          ),
                          conatiner(
                            height: 0.1,
                            width: 0.30,
                            assetName: BaseApi.imgUrl + image3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const FeaturedScreen());
                            },
                            child: conatiner(
                              height: 0.1,
                              width: 0.30,
                              assetName: BaseApi.imgUrl + image4,
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
                                  style: myTheme.textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                                    style: myTheme.textTheme.titleMedium,
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
                      // childCount: selectedValue == "Recent"
                      //     ? recentWallpaper.length
                      //     : selectedValue == "Trending"
                      //         ? trendingWallpaper.length
                      //         : exclusiveWallpaper.length,
                      itemBuilder: (context, index) {
                        final data = BlocProvider.of<PaginationBloc>(context)
                            .allWallpaper?[index];
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
                              imageUrl: BaseApi.imgUrl + image.toString(),
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
                                            likedWallpaper.contains(data?.id)
                                                ? SVGIconManager.liked
                                                : SVGIconManager.favorite,
                                            color: likedWallpaper
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
                                  child:
                                      SpinKitCircle(color: ColorManager.white)),
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
                          //         ? trendingWallpaper.length
                          //         : exclusiveWallpaper.length,
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
                                              likedWallpaper
                                                      .contains(data?.id ?? "")
                                                  ? SVGIconManager.liked
                                                  : SVGIconManager.favorite,
                                              color: likedWallpaper
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
                                    child: SpinKitCircle(
                                        color: ColorManager.white)),
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
