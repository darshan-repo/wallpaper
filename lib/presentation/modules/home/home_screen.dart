// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class HomeScreenInit extends StatelessWidget {
  const HomeScreenInit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaginationBloc>(
      create: (context) =>
          PaginationBloc()..add(PaginationInitialEvent(events: "Exclusive")),
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
  String selectedValue = 'Exclusive';
  final List items = [
    'Recent',
    'Trending',
    'Exclusive',
  ];

  bool isSelectGrid = true;

  List<String> likedWallpaper = [];
  final String userId = UserPreferences().getUserId();

  PaginationBloc? paginationBloc;

  @override
  void initState() {
    featuredImages();
    BlocProvider.of<PaginationBloc>(context)
        .add(GetExclusivePaginationDataEvent());
    paginationBloc = BlocProvider.of<PaginationBloc>(context);
    try {
      scrollController = ScrollController();
      scrollController?.addListener(() async {
        if (scrollController!.offset >=
                scrollController!.position.maxScrollExtent &&
            !scrollController!.position.outOfRange) {
          paginationBloc!.add(GetExclusivePaginationDataEvent());
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
    }
    super.initState();
  }

  late final String image1, image2, image3, image4;

  featuredImages() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetHomeFeatured());
    image1 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![0]
            .background!
            .split("/")
            .last ??
        "";
    image2 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories![1]
            .background!
            .split("/")
            .last ??
        "";
    image3 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories?[2]
            .background
            ?.split("/")
            .last ??
        "";
    image4 = BlocProvider.of<CollectionBlocBloc>(context)
            .getFeaturedWallpaperModel
            ?.categories?[3]
            .background
            ?.split("/")
            .last ??
        "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String userID = UserPreferences().getUserId();
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: BlocProvider.of<PaginationBloc>(context).allWallpaper == []
            ? const Center(child: CustomLoader())
            : BlocConsumer<PaginationBloc, PaginationState>(
                bloc: paginationBloc,
                listener: (BuildContext context, PaginationState state) {
                  if (state is SnackbarEvent) {
                    errorSnackbar(state.message);
                  }
                },
                buildWhen: (previous, current) =>
                    current is UserListRefreshState,
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
                        background: BlocBuilder<CollectionBlocBloc,
                            CollectionBlocState>(
                          builder: (BuildContext context,
                              CollectionBlocState state) {
                            if (state is CollectionLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.featured,
                                    style: myTheme.textTheme.titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                  verticalSpace(0.01.sh),
                                  conatiner(
                                    context,
                                    height: 0.2,
                                    width: double.infinity,
                                    assetName: BaseApi.imgUrl + image1,
                                  ),
                                  verticalSpace(0.009.sh),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      conatiner(
                                        context,
                                        assetName: BaseApi.imgUrl + image2,
                                      ),
                                      conatiner(
                                        context,
                                        assetName: BaseApi.imgUrl + image3,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(const FeaturedScreen());
                                        },
                                        child: conatiner(
                                          context,
                                          assetName: BaseApi.imgUrl + image4,
                                          child: Container(
                                            height: 0.1.sh,
                                            width: 0.30.sh,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            child: Text(
                                              '+ ${BlocProvider.of<CollectionBlocBloc>(context).getFeaturedWallpaperModel?.categories!.length}',
                                              style:
                                                  myTheme.textTheme.titleMedium,
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
                                                  fontWeight:
                                                      FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedValue = value as String;
                                      BlocProvider.of<PaginationBloc>(context)
                                          .add(
                                        PaginationInitialEvent(
                                            events: selectedValue),
                                      );
                                    },
                                  );
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
                                              ? const Color.fromRGBO(
                                                  160, 152, 250, 1)
                                              : ColorManager.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                            itemBuilder: (context, index) {
                              final image =
                                  BlocProvider.of<PaginationBloc>(context)
                                          .allWallpaper?[index]
                                          .wallpaper
                                          ?.split("/")
                                          .last ??
                                      "";
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    SetWallpaperScreen(
                                      imgURL: BaseApi.imgUrl + image,
                                      uploaded:
                                          '${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.day.toString()}/${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.month.toString()}/${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.year.toString()}',
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: (index % 4 + 1) * 100,
                                  child: cachedNetworkImage(
                                    imageUrl: BaseApi.imgUrl + image,
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
                                                      BaseApi.imgUrl + image);
                                              BlocProvider.of<
                                                          CollectionBlocBloc>(
                                                      context)
                                                  .add(
                                                SendDownloadWallpaper(
                                                  id: BlocProvider.of<
                                                                  PaginationBloc>(
                                                              context)
                                                          .allWallpaper?[index]
                                                          .id ??
                                                      "",
                                                  userId: UserPreferences()
                                                      .getUserId(),
                                                  name: BlocProvider.of<
                                                                  PaginationBloc>(
                                                              context)
                                                          .allWallpaper?[index]
                                                          .name ??
                                                      "",
                                                  category: BlocProvider.of<
                                                                  PaginationBloc>(
                                                              context)
                                                          .allWallpaper?[index]
                                                          .category ??
                                                      "",
                                                  wallpaper: BlocProvider.of<
                                                                  PaginationBloc>(
                                                              context)
                                                          .allWallpaper?[index]
                                                          .wallpaper ??
                                                      "",
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
                                              if (!likedWallpaper.contains(
                                                  BlocProvider.of<PaginationBloc>(
                                                              context)
                                                          .allWallpaper?[index]
                                                          .id ??
                                                      "")) {
                                                likedWallpaper.add(BlocProvider
                                                            .of<PaginationBloc>(
                                                                context)
                                                        .allWallpaper?[index]
                                                        .id ??
                                                    "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendLikedWallpaper(
                                                    id: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .id ??
                                                        "",
                                                    userId: UserPreferences()
                                                        .getUserId(),
                                                    name: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .name ??
                                                        "",
                                                    category: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .category ??
                                                        "",
                                                    wallpaper: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .wallpaper ??
                                                        "",
                                                  ),
                                                );
                                                setState(() {});
                                              } else {
                                                likedWallpaper.remove(BlocProvider
                                                            .of<PaginationBloc>(
                                                                context)
                                                        .allWallpaper![index]
                                                        .id ??
                                                    "");
                                                BlocProvider.of<
                                                            CollectionBlocBloc>(
                                                        context)
                                                    .add(
                                                  SendDissLikeWallpaper(
                                                    id: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .id ??
                                                        "",
                                                    userId: UserPreferences()
                                                        .getUserId(),
                                                  ),
                                                );
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            likedWallpaper.contains(BlocProvider
                                                        .of<PaginationBloc>(
                                                            context)
                                                    .allWallpaper?[index]
                                                    .id)
                                                ? SVGIconManager.liked
                                                : SVGIconManager.favorite,
                                            color: likedWallpaper.contains(
                                                    BlocProvider.of<
                                                                PaginationBloc>(
                                                            context)
                                                        .allWallpaper?[index]
                                                        .id)
                                                ? ColorManager.red
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                childCount:
                                    BlocProvider.of<PaginationBloc>(context)
                                        .allWallpaper
                                        ?.length,
                                (context, index) {
                                  final image =
                                      BlocProvider.of<PaginationBloc>(context)
                                          .allWallpaper?[index]
                                          .wallpaper
                                          ?.split("/")
                                          .last;
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        SetWallpaperScreen(
                                          imgURL:
                                              BaseApi.imgUrl + image.toString(),
                                          uploaded:
                                              '${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.day.toString()}/${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.month.toString()}/${BlocProvider.of<PaginationBloc>(context).allWallpaper?[index].createdAt!.year.toString()}',
                                        ),
                                      );
                                    },
                                    child: cachedNetworkImage(
                                      imageUrl: BaseApi.imgUrl + image!,
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
                                                    id: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .id ??
                                                        "",
                                                    userId: UserPreferences()
                                                        .getUserId(),
                                                    name: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .name ??
                                                        "",
                                                    category: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .category ??
                                                        "",
                                                    wallpaper: BlocProvider.of<
                                                                    PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .wallpaper ??
                                                        "",
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
                                                if (!likedWallpaper.contains(
                                                    BlocProvider.of<PaginationBloc>(
                                                                context)
                                                            .allWallpaper?[
                                                                index]
                                                            .id ??
                                                        "")) {
                                                  likedWallpaper.add(BlocProvider
                                                              .of<PaginationBloc>(
                                                                  context)
                                                          .allWallpaper?[index]
                                                          .id ??
                                                      "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendLikedWallpaper(
                                                      id: BlocProvider.of<
                                                                      PaginationBloc>(
                                                                  context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .id ??
                                                          "",
                                                      userId: UserPreferences()
                                                          .getUserId(),
                                                      name: BlocProvider.of<
                                                                      PaginationBloc>(
                                                                  context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      category: BlocProvider.of<
                                                                      PaginationBloc>(
                                                                  context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .category ??
                                                          "",
                                                      wallpaper: BlocProvider
                                                                  .of<PaginationBloc>(
                                                                      context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .wallpaper ??
                                                          "",
                                                    ),
                                                  );
                                                  setState(() {});
                                                } else {
                                                  likedWallpaper.remove(BlocProvider
                                                              .of<PaginationBloc>(
                                                                  context)
                                                          .allWallpaper?[index]
                                                          .id ??
                                                      "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendDissLikeWallpaper(
                                                      id: BlocProvider.of<
                                                                      PaginationBloc>(
                                                                  context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .id ??
                                                          "",
                                                      userId: UserPreferences()
                                                          .getUserId(),
                                                    ),
                                                  );
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              likedWallpaper.contains(BlocProvider
                                                              .of<PaginationBloc>(
                                                                  context)
                                                          .allWallpaper?[index]
                                                          .id ??
                                                      "")
                                                  ? SVGIconManager.liked
                                                  : SVGIconManager.favorite,
                                              color: likedWallpaper.contains(
                                                      BlocProvider.of<PaginationBloc>(
                                                                  context)
                                                              .allWallpaper?[
                                                                  index]
                                                              .id ??
                                                          "")
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
                  ],
                ),
              ),
      ),
    );
  }
}
