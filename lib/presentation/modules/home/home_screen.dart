// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

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

  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetAllWallpaper());
    super.initState();
  }

  String? selectedValue = 'Trending';
  bool isSelectGrid = true;
  bool isSelect = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String userID = UserPreferences.getUserId();
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
          builder: (context, state) {
            if (state is CollectionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.white),
              );
            } else if (state is CollectionLoaded) {
              return CustomScrollView(
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
                            assetName: ImageJPGManager.seaSky,
                          ),
                          verticalSpace(0.009.sh),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              conatiner(
                                height: 0.1,
                                width: 0.30,
                                assetName: ImageJPGManager.bananas,
                              ),
                              conatiner(
                                height: 0.1,
                                width: 0.30,
                                assetName: ImageJPGManager.yellowPinkColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(const FeaturedScreen());
                                },
                                child: conatiner(
                                  height: 0.1,
                                  width: 0.30,
                                  assetName: ImageJPGManager.bananas,
                                  child: Container(
                                    height: 0.1.sh,
                                    width: 0.30.sh,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      '+99',
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
                                  selectedValue = value.toString();
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
                                            ? const Color.fromRGBO(
                                                160, 152, 250, 1)
                                            : ColorManager.primaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: SvgPicture.asset(
                                        SVGIconManager.gridCollection,
                                        color: ColorManager.white,
                                      ),
                                      // child: Image.asset(
                                      //   fit: BoxFit.contain,
                                      //   ImageAssetManager.grid,
                                      //   color: ColorManager.white,
                                      // ),
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
                          childCount:
                              BlocProvider.of<CollectionBlocBloc>(context)
                                  .getAllWallpaperModel
                                  ?.wallpapers
                                  ?.length,
                          itemBuilder: (context, index) {
                            final data =
                                BlocProvider.of<CollectionBlocBloc>(context)
                                    .getAllWallpaperModel!
                                    .wallpapers?[index];
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
                              child: homeGridview(
                                assetName: BaseApi.imgUrl + image!,
                                height: (index % 5 + 1) * 100,
                                downloadOnTap: () {
                                  if (userID.isEmpty) {
                                    Get.to(const LoginScreen());
                                  } else {
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .add(
                                      SendDownloadWallpaper(
                                        id: data?.id ?? "",
                                        userId: UserPreferences.getUserId(),
                                        name: data?.name ?? "",
                                        category: data?.category ?? "",
                                        wallpaper: data?.wallpaper ?? "",
                                      ),
                                    );
                                    successSnackbar(
                                        'wallpaper successfully downloaded!');
                                  }
                                },
                                favoriteOnTap: () {
                                  if (userID.isEmpty) {
                                    Get.to(const LoginScreen());
                                  } else {
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .add(
                                      SendLikedWallpaper(
                                        id: data?.id ?? "",
                                        userId: UserPreferences.getUserId(),
                                        name: data?.name ?? "",
                                        category: data?.category ?? "",
                                        wallpaper: data?.wallpaper ?? "",
                                      ),
                                    );
                                  }
                                },
                                isSelect: isSelect,
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
                                  BlocProvider.of<CollectionBlocBloc>(context)
                                      .getAllWallpaperModel!
                                      .wallpapers!
                                      .length,
                              (context, index) {
                                final data =
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .getAllWallpaperModel!
                                        .wallpapers?[index];
                                final image = data?.wallpaper?.split("/").last;
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      SetWallpaperScreen(
                                        imgURL:
                                            BaseApi.imgUrl + image.toString(),
                                        uploaded:
                                            '${data?.createdAt!.day.toString()}/${data?.createdAt!.month.toString()}/${data?.createdAt!.year.toString()}',
                                      ),
                                    );
                                  },
                                  child: homeGridview(
                                    assetName: BaseApi.imgUrl + image!,
                                    downloadOnTap: () {
                                      if (userID.isEmpty) {
                                        Get.to(const LoginScreen());
                                      } else {
                                        BlocProvider.of<CollectionBlocBloc>(
                                                context)
                                            .add(
                                          SendDownloadWallpaper(
                                            id: data?.id ?? "",
                                            userId: UserPreferences.getUserId(),
                                            name: data?.name ?? "",
                                            category: data?.category ?? "",
                                            wallpaper: data?.wallpaper ?? "",
                                          ),
                                        );
                                        successSnackbar(
                                            'wallpaper successfully downloaded!');
                                      }
                                    },
                                    favoriteOnTap: () {
                                      if (userID.isEmpty) {
                                        Get.to(const LoginScreen());
                                      } else {
                                        BlocProvider.of<CollectionBlocBloc>(
                                                context)
                                            .add(
                                          SendLikedWallpaper(
                                            id: data?.id ?? "",
                                            userId: UserPreferences.getUserId(),
                                            name: data?.name ?? "",
                                            category: data?.category ?? "",
                                            wallpaper: data?.wallpaper ?? "",
                                          ),
                                        );
                                      }
                                    },
                                    isSelect: isSelect,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
