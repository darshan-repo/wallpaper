import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:walper/libs.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
          actionIcon: Icons.filter_alt_outlined,
          actionOnTap: () {
            Get.to(const FilterScreen());
          },
        ),
        body: Padding(
          padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorites',
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
                          child: CircularProgressIndicator(
                              color: ColorManager.white),
                        ),
                      ],
                    );
                  } else if (state is CollectionLoaded) {
                    return BlocProvider.of<CollectionBlocBloc>(context)
                            .getLikedModel!
                            .likesData!
                            .isEmpty
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
                                  'Oops ! No favorites to display',
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
                                        .getLikedModel!
                                        .likesData!
                                        .length,
                                itemBuilder: (context, index) {
                                  final image =
                                      BlocProvider.of<CollectionBlocBloc>(
                                              context)
                                          .getLikedModel!
                                          .likesData![index]
                                          .wallpaper
                                          ?.split("/")
                                          .last;
                                  return CachedNetworkImage(
                                    imageUrl: BaseApi.imgUrl + image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: imageProvider,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.05),
                                        ),
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: padding(
                                              paddingType: PaddingType.LTRB,
                                              right: 0.01.sw,
                                              bottom: 0.01.sh),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              CollectionBlocBloc>(
                                                          context)
                                                      .add(
                                                    SendDownloadWallpaper(
                                                      id: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getLikedModel!
                                                              .likesData![index]
                                                              .id ??
                                                          "",
                                                      userId: UserPreferences
                                                          .getUserId(),
                                                      name: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getLikedModel!
                                                              .likesData![index]
                                                              .name ??
                                                          "",
                                                      category: BlocProvider.of<
                                                                      CollectionBlocBloc>(
                                                                  context)
                                                              .getLikedModel!
                                                              .likesData![index]
                                                              .category ??
                                                          "",
                                                      wallpaper: BlocProvider
                                                                  .of<CollectionBlocBloc>(
                                                                      context)
                                                              .getLikedModel!
                                                              .likesData![index]
                                                              .wallpaper ??
                                                          "",
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.file_download_outlined,
                                                  size: 0.035.sh,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                              verticalSpace(0.02.sh),
                                              Icon(
                                                Icons.favorite_rounded,
                                                size: 0.035.sh,
                                                color: ColorManager.red,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                      child: SpinKitCircle(
                                          color: ColorManager.white),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
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
