// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show get;
import 'package:walper/libs.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List<String> likedWallpaper = [];
  final String userId = UserPreferences().getUserId();

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
                AppString.downloads,
                style: myTheme.textTheme.titleLarge,
              ),
              verticalSpace(0.01.sh),
              Text(
                AppString.downloadDesc,
                style: myTheme.textTheme.labelMedium,
              ),
              verticalSpace(0.01.sh),
              BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
                builder: (context, state) {
                  if (state is CollectionLoading) {
                    return Column(
                      children: [
                        verticalSpace(0.3.sh),
                        const CustomLoader(),
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
                                  AppString.oopsNoDownloadsToDisplay,
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
                                  final data =
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getDownloadModel!
                                          .downloadData![index];
                                  final image = data.wallpaper?.split("/").last;
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
                                                AppString.downloads,
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
                                                            '${data.createdAt!.day.toString()}/${data.createdAt!.month.toString()}/${data.createdAt!.year.toString()}'),
                                                  );
                                                },
                                                child: bottomContent(
                                                  assetName:
                                                      ImageAssetManager.mobile,
                                                  title: AppString.setWallpaper,
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
                                                      icon:
                                                          CachedNetworkImageBuilder(
                                                        url: BaseApi.imgUrl +
                                                            image,
                                                        builder: (image) =>
                                                            Padding(
                                                          padding: padding(
                                                              paddingType:
                                                                  PaddingType
                                                                      .horizontal,
                                                              paddingValue:
                                                                  0.15.sw),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child: SizedBox(
                                                              height: 0.15.sh,
                                                              child: Image.file(
                                                                image,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        placeHolder:
                                                            const CustomLoader(),
                                                        errorWidget: const Icon(
                                                            Icons.error),
                                                      ),
                                                      title: Text(
                                                        AppString.removeItem,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: myTheme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      content: Text(
                                                        AppString
                                                            .areYouSureWantToRemoveThisItem,
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
                                                                id: data
                                                                    .wallpaperId!,
                                                                userId: data
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
                                                                id: UserPreferences()
                                                                    .getUserId(),
                                                              ),
                                                            );
                                                          },
                                                          buttonColor:
                                                              const Color(
                                                                  0xFFA098FA),
                                                          buttonText:
                                                              AppString.sure,
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
                                                              AppString
                                                                  .noThanks,
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
                                                  title: AppString.delete,
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
                                                  title: AppString.share,
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
                                                  title: AppString.reportThis,
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
                                                buttonText: AppString.cancle,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: cachedNetworkImage(
                                      imageUrl: BaseApi.imgUrl + image!,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!likedWallpaper
                                              .contains(data.id ?? "")) {
                                            likedWallpaper.add(data.id ?? "");
                                            BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .add(
                                              SendLikedWallpaper(
                                                id: data.id ?? "",
                                                userId: UserPreferences()
                                                    .getUserId(),
                                                name: data.name ?? "",
                                                category: data.category ?? "",
                                                wallpaper: data.wallpaper ?? "",
                                              ),
                                            );
                                            setState(() {});
                                          } else {
                                            likedWallpaper
                                                .remove(data.id ?? "");
                                            BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .add(
                                              SendDissLikeWallpaper(
                                                id: data.id ?? "",
                                                userId: UserPreferences()
                                                    .getUserId(),
                                              ),
                                            );
                                            setState(() {});
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          likedWallpaper.contains(data.id)
                                              ? SVGIconManager.liked
                                              : SVGIconManager.favorite,
                                          color:
                                              likedWallpaper.contains(data.id)
                                                  ? ColorManager.red
                                                  : ColorManager.white,
                                        ),
                                      ),
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
