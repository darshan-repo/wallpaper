// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TextEditingController txtSearchController = TextEditingController();

  TabController? tabController;

  List<String> likedWallpaper = [];
  final String userId = UserPreferences.getUserId();

  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetAllWallpaper());
    BlocProvider.of<CollectionBlocBloc>(context).add(GetWallpaper());
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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

  int tabIndex = 0;
  bool isShowColor = true;
  bool isSelect = false;

  List<Wallpaper> searchWallpaperModel = [];
  List<Category> searchCategoryWallpaperModel = [];

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
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.01.sh),
          Text(
            'seaching through hundreds of photos will be so much easier now.',
            style: myTheme.textTheme.labelSmall,
          ),
          verticalSpace(0.02.sh),
          TextFormField(
            controller: txtSearchController,
            style: myTheme.textTheme.labelMedium,
            cursorColor: ColorManager.white,
            onChanged: (value) {
              setState(() {
                tabIndex == 0
                    ? searchWallpaperModel =
                        BlocProvider.of<CollectionBlocBloc>(context)
                            .getAllWallpaperModel!
                            .wallpapers!
                            .where((item) => item.name!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList()
                    : searchCategoryWallpaperModel =
                        BlocProvider.of<CollectionBlocBloc>(context)
                            .getWallpaperModel!
                            .categories!
                            .where((item) => item.name!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorManager.secondaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorManager.secondaryColor, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: ColorManager.secondaryColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(104, 97, 228, 1),
                  width: 2,
                ),
              ),
              prefixIcon: const Icon(Icons.search, color: ColorManager.white),
              hintText: 'Search...',
              hintStyle: myTheme.textTheme.labelMedium,
            ),
          ),
          verticalSpace(0.02.sh),
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            onTap: (value) {
              setState(() {
                tabIndex = value;
              });
            },
            overlayColor:
                MaterialStateProperty.all(ColorManager.transparentColor),
            labelPadding:
                padding(paddingType: PaddingType.bottom, paddingValue: 0.01.sh),
            indicatorColor: const Color.fromRGBO(104, 97, 228, 1),
            tabs: [
              Text(
                'Photo',
                style: tabIndex == 0
                    ? myTheme.textTheme.displaySmall
                    : myTheme.textTheme.labelMedium,
              ),
              Text(
                'Category',
                style: tabIndex == 1
                    ? myTheme.textTheme.displaySmall
                    : myTheme.textTheme.labelMedium,
              ),
            ],
          ),
          verticalSpace(0.02.sh),
          Expanded(
            child: BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
              builder: (context, state) {
                if (state is CollectionLoading) {
                  return const Center(
                    child: SpinKitCircle(color: ColorManager.white),
                  );
                } else if (state is CollectionLoaded) {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: searchWallpaperModel.isEmpty &&
                                txtSearchController.text.isEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.65,
                                ),
                                itemCount:
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .getAllWallpaperModel
                                        ?.wallpapers!
                                        .length,
                                itemBuilder: (context, index) {
                                  var data =
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getAllWallpaperModel!
                                          .wallpapers?[index];
                                  final image =
                                      data!.wallpaper!.split("/").last;
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        SetWallpaperScreen(
                                          imgURL:
                                              BaseApi.imgUrl + image.toString(),
                                          uploaded:
                                              '${data.createdAt!.day.toString()}/${data.createdAt!.month.toString()}/${data.createdAt!.year.toString()}',
                                        ),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: BaseApi.imgUrl + image,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: imageProvider,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.black.withOpacity(0.05),
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
                                                      Get.to(
                                                          const LoginScreen());
                                                    } else {
                                                      downloadAndSaveImageToGallery(
                                                          imageUrl:
                                                              BaseApi.imgUrl +
                                                                  image);
                                                      BlocProvider.of<
                                                                  CollectionBlocBloc>(
                                                              context)
                                                          .add(
                                                        SendDownloadWallpaper(
                                                          id: data.id ?? "",
                                                          userId:
                                                              UserPreferences
                                                                  .getUserId(),
                                                          name: data.name ?? "",
                                                          category:
                                                              data.category ??
                                                                  "",
                                                          wallpaper:
                                                              data.wallpaper ??
                                                                  "",
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .file_download_outlined,
                                                    size: 0.035.sh,
                                                    color: ColorManager.white,
                                                  ),
                                                ),
                                                verticalSpace(0.02.sh),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (userID.isEmpty) {
                                                      Get.to(
                                                          const LoginScreen());
                                                    } else {
                                                      if (!likedWallpaper
                                                          .contains(
                                                              data.id ?? "")) {
                                                        likedWallpaper
                                                            .add(data.id ?? "");
                                                        BlocProvider.of<
                                                                    CollectionBlocBloc>(
                                                                context)
                                                            .add(
                                                          SendLikedWallpaper(
                                                            id: data.id ?? "",
                                                            userId:
                                                                UserPreferences
                                                                    .getUserId(),
                                                            name:
                                                                data.name ?? "",
                                                            category:
                                                                data.category ??
                                                                    "",
                                                            wallpaper:
                                                                data.wallpaper ??
                                                                    "",
                                                          ),
                                                        );
                                                        setState(() {});
                                                      } else {
                                                        likedWallpaper.remove(
                                                            data.id ?? "");
                                                        BlocProvider.of<
                                                                    CollectionBlocBloc>(
                                                                context)
                                                            .add(
                                                          SendDissLikeWallpaper(
                                                            id: data.id ?? "",
                                                            userId:
                                                                UserPreferences
                                                                    .getUserId(),
                                                          ),
                                                        );
                                                        setState(() {});
                                                      }
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    likedWallpaper
                                                            .contains(data.id)
                                                        ? SVGIconManager.liked
                                                        : SVGIconManager
                                                            .favorite,
                                                    color: likedWallpaper
                                                            .contains(data.id)
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
                                        child: SpinKitCircle(
                                            color: ColorManager.white),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  );
                                },
                              )
                            : searchWallpaperModel.isEmpty &&
                                    txtSearchController.text.isNotEmpty
                                ? Center(
                                    child: SvgPicture.asset(
                                      ImageSVGManager.noWallpaperFound,
                                      height: 0.3.sh,
                                      width: 0.3.sw,
                                    ),
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.65,
                                    ),
                                    itemCount: searchWallpaperModel.length,
                                    itemBuilder: (context, index) {
                                      final image = searchWallpaperModel[index]
                                          .wallpaper!
                                          .split("/")
                                          .last;
                                      return CachedNetworkImage(
                                        imageUrl: BaseApi.imgUrl + image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: imageProvider,
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black
                                                  .withOpacity(0.05),
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
                                                        Get.to(
                                                            const LoginScreen());
                                                      } else {
                                                        downloadAndSaveImageToGallery(
                                                            imageUrl:
                                                                BaseApi.imgUrl +
                                                                    image);
                                                        BlocProvider.of<
                                                                    CollectionBlocBloc>(
                                                                context)
                                                            .add(
                                                          SendDownloadWallpaper(
                                                            id: searchWallpaperModel[
                                                                        index]
                                                                    .id ??
                                                                "",
                                                            userId:
                                                                UserPreferences
                                                                    .getUserId(),
                                                            name: searchWallpaperModel[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            category: searchWallpaperModel[
                                                                        index]
                                                                    .category ??
                                                                "",
                                                            wallpaper:
                                                                searchWallpaperModel[
                                                                            index]
                                                                        .wallpaper ??
                                                                    "",
                                                          ),
                                                        );
                                                        successSnackbar(
                                                            'wallpaper successfully downloaded!');
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .file_download_outlined,
                                                      size: 0.035.sh,
                                                      color: ColorManager.white,
                                                    ),
                                                  ),
                                                  verticalSpace(0.02.sh),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (userID.isEmpty) {
                                                        Get.to(
                                                            const LoginScreen());
                                                      } else {
                                                        if (!likedWallpaper.contains(
                                                            searchWallpaperModel[
                                                                        index]
                                                                    .id ??
                                                                "")) {
                                                          likedWallpaper.add(
                                                              searchWallpaperModel[
                                                                          index]
                                                                      .id ??
                                                                  "");
                                                          BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .add(
                                                            SendLikedWallpaper(
                                                              id: searchWallpaperModel[
                                                                          index]
                                                                      .id ??
                                                                  "",
                                                              userId:
                                                                  UserPreferences
                                                                      .getUserId(),
                                                              name: searchWallpaperModel[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              category: searchWallpaperModel[
                                                                          index]
                                                                      .category ??
                                                                  "",
                                                              wallpaper: searchWallpaperModel[
                                                                          index]
                                                                      .wallpaper ??
                                                                  "",
                                                            ),
                                                          );
                                                          setState(() {});
                                                        } else {
                                                          likedWallpaper.remove(
                                                              searchWallpaperModel[
                                                                          index]
                                                                      .id ??
                                                                  "");
                                                          BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .add(
                                                            SendDissLikeWallpaper(
                                                              id: searchWallpaperModel[
                                                                          index]
                                                                      .id ??
                                                                  "",
                                                              userId:
                                                                  UserPreferences
                                                                      .getUserId(),
                                                            ),
                                                          );
                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      likedWallpaper.contains(
                                                              searchWallpaperModel[
                                                                      index]
                                                                  .id)
                                                          ? SVGIconManager.liked
                                                          : SVGIconManager
                                                              .favorite,
                                                      color: likedWallpaper
                                                              .contains(
                                                                  searchWallpaperModel[
                                                                          index]
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
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SpinKitCircle(
                                              color: ColorManager.white),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      );
                                    },
                                  ),
                      ),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: searchCategoryWallpaperModel.isEmpty &&
                                txtSearchController.text.isEmpty
                            ? ListView.builder(
                                itemCount:
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .getWallpaperModel
                                        ?.categories
                                        ?.length,
                                itemBuilder: (context, index) {
                                  final image =
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getWallpaperModel!
                                          .categories![index]
                                          .background!
                                          .split("/")
                                          .last;
                                  return GestureDetector(
                                    onTap: () {},
                                    child: SizedBox(
                                      height: 0.19.sh,
                                      child: CachedNetworkImage(
                                        imageUrl: BaseApi.imgUrl + image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          margin: margin(
                                              marginType: MarginType.bottom,
                                              marginValue: 0.01.sh),
                                          height: 0.19.sh,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: Container(
                                            padding: padding(
                                                paddingType: PaddingType.left,
                                                paddingValue: 0.08.sw),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  BlocProvider.of<CollectionBlocBloc>(
                                                              context)
                                                          .getWallpaperModel!
                                                          .categories![index]
                                                          .name ??
                                                      "",
                                                  style: myTheme
                                                      .textTheme.titleLarge,
                                                ),
                                                verticalSpace(0.02.sh),
                                                Text(
                                                  '${BlocProvider.of<CollectionBlocBloc>(context).getWallpaperModel!.categories![index].categoryDatas!.length} walpapers',
                                                  style: myTheme
                                                      .textTheme.labelMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SpinKitCircle(
                                              color: ColorManager.white),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : searchCategoryWallpaperModel.isEmpty &&
                                    txtSearchController.text.isNotEmpty
                                ? Center(
                                    child: SvgPicture.asset(
                                      ImageSVGManager.noWallpaperFound,
                                      height: 0.3.sh,
                                      width: 0.3.sw,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        searchCategoryWallpaperModel.length,
                                    itemBuilder: (context, index) {
                                      final image =
                                          searchCategoryWallpaperModel[index]
                                              .background!
                                              .split("/")
                                              .last;
                                      return GestureDetector(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: 0.19.sh,
                                          child: CachedNetworkImage(
                                            imageUrl: BaseApi.imgUrl + image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              margin: margin(
                                                  marginType: MarginType.bottom,
                                                  marginValue: 0.01.sh),
                                              height: 0.19.sh,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: Container(
                                                padding: padding(
                                                    paddingType:
                                                        PaddingType.left,
                                                    paddingValue: 0.08.sw),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      searchCategoryWallpaperModel[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      style: myTheme
                                                          .textTheme.titleLarge,
                                                    ),
                                                    verticalSpace(0.02.sh),
                                                    Text(
                                                      '${searchCategoryWallpaperModel[index].categoryDatas!.length} wallpapers',
                                                      style: myTheme.textTheme
                                                          .labelMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: SpinKitCircle(
                                                  color: ColorManager.white),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
