// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:walper/libs.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: appbar(
          context,
          leadingOnTap: () {
            Get.off(const BottomNavigationBarScreen());
          },
        ),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Downloads',
                style: myTheme.textTheme.titleLarge,
              ),
              verticalSpace(0.01.sh),
              Text(
                'You\'ve marked all of these as a favorite!',
                style: myTheme.textTheme.labelMedium,
              ),
              verticalSpace(0.01.sh),
              BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
                builder: (context, state) {
                  if (state is CollectionLoading) {
                    return Column(
                      children: [
                        verticalSpace(0.3.sh),
                        const Center(
                          child: SpinKitCircle(color: ColorManager.white),
                        ),
                      ],
                    );
                  } else if (state is CollectionLoaded) {
                    return BlocProvider.of<CollectionBlocBloc>(context)
                            .getDownloadModel!
                            .downloadData!
                            .isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                verticalSpace(0.15.sh),
                                Image.asset(
                                  ImageAssetManager.deleteDownloads,
                                  scale: 0.003.sh,
                                ),
                                Text(
                                  'Oops ! No downloads to display',
                                  style: TextStyle(
                                    fontSize: FontSize.s18,
                                    fontFamily: FontFamily.roboto,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeightManager.semiBold,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: <Color>[
                                          Color.fromRGBO(160, 152, 250, 1),
                                          Color.fromRGBO(175, 117, 112, 1),
                                          Colors.yellow
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(
                                            100.0, 0.0, 180.0, 70.0),
                                      ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
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
                                itemCount:
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .getDownloadModel!
                                        .downloadData!
                                        .length,
                                itemBuilder: (context, index) {
                                  final image =
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getDownloadModel!
                                          .downloadData![index]
                                          .wallpaper
                                          ?.split("/")
                                          .last;
                                  return InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        elevation: 0,
                                        backgroundColor:
                                            ColorManager.secondaryColor,
                                        context: context,
                                        isDismissible: false,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) => Container(
                                          height: 0.5.sh,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          padding: padding(
                                              paddingType: PaddingType.all,
                                              paddingValue: 0.02.sh),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Downloads',
                                                style: myTheme
                                                    .textTheme.titleLarge,
                                              ),
                                              verticalSpace(0.05.sh),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);

                                                  Get.to(
                                                    () => SetWallpaperScreen(
                                                        imgURL: BaseApi.imgUrl +
                                                            image,
                                                        uploaded:
                                                            '${BlocProvider.of<CollectionBlocBloc>(context).getDownloadModel!.downloadData![index].createdAt!.day.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getDownloadModel!.downloadData![index].createdAt!.month.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getDownloadModel!.downloadData![index].createdAt!.year.toString()}'),
                                                  );
                                                },
                                                child: bottomContent(
                                                  assetName:
                                                      ImageAssetManager.mobile,
                                                  title: 'Set wallpaper',
                                                ),
                                              ),
                                              verticalSpace(0.04.sh),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      backgroundColor:
                                                          ColorManager
                                                              .secondaryColor,
                                                      icon: CachedNetworkImage(
                                                        imageUrl:
                                                            BaseApi.imgUrl +
                                                                image,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          margin: margin(
                                                              marginType:
                                                                  MarginType
                                                                      .horizontal,
                                                              marginValue:
                                                                  0.15.sw),
                                                          height: 0.15.sh,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child: SpinKitCircle(
                                                              color:
                                                                  ColorManager
                                                                      .white),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                      title: Text(
                                                        'Remove item?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: myTheme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      content: Text(
                                                        'Are you sure want to remove this item?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: myTheme.textTheme
                                                            .headlineSmall,
                                                      ),
                                                      elevation: 2,
                                                      shadowColor:
                                                          ColorManager.white,
                                                      actions: [
                                                        materialButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        CollectionBlocBloc>(
                                                                    context)
                                                                .add(
                                                              DeleteDownloadWallpaper(
                                                                id: BlocProvider.of<
                                                                            CollectionBlocBloc>(
                                                                        context)
                                                                    .getDownloadModel!
                                                                    .downloadData![
                                                                        index]
                                                                    .wallpaperId!,
                                                                userId: BlocProvider.of<
                                                                            CollectionBlocBloc>(
                                                                        context)
                                                                    .getDownloadModel!
                                                                    .downloadData![
                                                                        index]
                                                                    .userId!,
                                                              ),
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            BlocProvider.of<
                                                                        CollectionBlocBloc>(
                                                                    context)
                                                                .add(
                                                              GetDownloadWallpaper(
                                                                id: UserPreferences
                                                                    .getUserId(),
                                                              ),
                                                            );
                                                          },
                                                          buttonColor:
                                                              const Color(
                                                                  0xFFA098FA),
                                                          buttonText: 'Sure',
                                                        ),
                                                        verticalSpace(0.03.sh),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'No, thanks',
                                                              style: myTheme
                                                                  .textTheme
                                                                  .displaySmall,
                                                            ),
                                                          ),
                                                        ),
                                                        verticalSpace(0.02.sh),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: bottomContent(
                                                  assetName:
                                                      ImageAssetManager.delete,
                                                  title: 'Delete',
                                                ),
                                              ),
                                              verticalSpace(0.04.sh),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  final response = await get(
                                                      Uri.parse(BaseApi.imgUrl +
                                                          image));
                                                  final directory =
                                                      await getTemporaryDirectory();
                                                  File file = await File(
                                                          '${directory.path}/Image.png')
                                                      .writeAsBytes(
                                                          response.bodyBytes);
                                                  await Share.shareXFiles(
                                                      [XFile(file.path)]);
                                                  setState(() {});
                                                },
                                                child: bottomContent(
                                                  assetName:
                                                      ImageAssetManager.share,
                                                  title: 'Share',
                                                ),
                                              ),
                                              verticalSpace(0.04.sh),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Get.to(() =>
                                                      const ReportAnIssueScreen());
                                                },
                                                child: bottomContent(
                                                  assetName: ImageAssetManager
                                                      .reportAnIssue,
                                                  title: 'Report this',
                                                ),
                                              ),
                                              verticalSpace(0.02.sh),
                                              const Divider(
                                                color:
                                                    ColorManager.primaryColor,
                                              ),
                                              materialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                buttonColor:
                                                    const Color.fromRGBO(
                                                        255, 128, 147, 1),
                                                buttonText: 'Cancle',
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: BaseApi.imgUrl + image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorManager.secondaryColor,
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
                                                bottom: 0.01.sh),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (!likedWallpaper.contains(
                                                    BlocProvider.of<CollectionBlocBloc>(
                                                                context)
                                                            .getDownloadModel!
                                                            .downloadData![
                                                                index]
                                                            .id ??
                                                        "")) {
                                                  likedWallpaper.add(BlocProvider
                                                              .of<CollectionBlocBloc>(
                                                                  context)
                                                          .getDownloadModel!
                                                          .downloadData![index]
                                                          .id ??
                                                      "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendLikedWallpaper(
                                                      id: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getDownloadModel!
                                                              .downloadData![
                                                                  index]
                                                              .id ??
                                                          "",
                                                      userId: UserPreferences
                                                          .getUserId(),
                                                      name: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getDownloadModel!
                                                              .downloadData![
                                                                  index]
                                                              .name ??
                                                          "",
                                                      category: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getDownloadModel!
                                                              .downloadData![
                                                                  index]
                                                              .category ??
                                                          "",
                                                      wallpaper: BlocProvider
                                                                  .of<CollectionBlocBloc>(
                                                                      context)
                                                              .getDownloadModel!
                                                              .downloadData![
                                                                  index]
                                                              .wallpaper ??
                                                          "",
                                                    ),
                                                  );
                                                  setState(() {});
                                                } else {
                                                  likedWallpaper.remove(BlocProvider
                                                              .of<CollectionBlocBloc>(
                                                                  context)
                                                          .getDownloadModel!
                                                          .downloadData![index]
                                                          .id ??
                                                      "");
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendDissLikeWallpaper(
                                                      id: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getDownloadModel!
                                                              .downloadData![
                                                                  index]
                                                              .id ??
                                                          "",
                                                      userId: UserPreferences
                                                          .getUserId(),
                                                    ),
                                                  );
                                                  setState(() {});
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                likedWallpaper.contains(BlocProvider
                                                            .of<CollectionBlocBloc>(
                                                                context)
                                                        .getDownloadModel!
                                                        .downloadData![index]
                                                        .id)
                                                    ? SVGIconManager.liked
                                                    : SVGIconManager.favorite,
                                                color: likedWallpaper.contains(
                                                        BlocProvider.of<
                                                                    CollectionBlocBloc>(
                                                                context)
                                                            .getDownloadModel!
                                                            .downloadData![
                                                                index]
                                                            .id)
                                                    ? ColorManager.red
                                                    : ColorManager.white,
                                              ),
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
                              ),
                            ),
                          );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
