import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:walper/libs.dart';

class CollectionViewScreen extends StatefulWidget {
  final String id;
  final String category;

  const CollectionViewScreen(
      {super.key, required this.id, required this.category});

  @override
  State<CollectionViewScreen> createState() => _CollectionViewScreenState();
}

class _CollectionViewScreenState extends State<CollectionViewScreen> {
  bool isLiked = false;

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
        child: BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
          builder: (context, state) {
            if (state is CollectionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.white),
              );
            } else if (state is CollectionLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category,
                    style: myTheme.textTheme.titleLarge,
                  ),
                  verticalSpace(0.01.sh),
                  Text(
                    "${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel?.data!.length.toString()} Wallpaper",
                    style: myTheme.textTheme.labelMedium,
                  ),
                  verticalSpace(0.01.sh),
                  Expanded(
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
                        itemCount: BlocProvider.of<CollectionBlocBloc>(context)
                            .getCollectionModel
                            ?.data!
                            .length,
                        itemBuilder: (context, index) {
                          final data =
                              BlocProvider.of<CollectionBlocBloc>(context)
                                  .getCollectionModel!
                                  .data![index];
                          final image =
                              BlocProvider.of<CollectionBlocBloc>(context)
                                  .getCollectionModel
                                  ?.data![index]
                                  .wallpaper!
                                  .split("/")
                                  .last;
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                SetWallpaperScreen(
                                  imgURL: BaseApi.imgUrl + image.toString(),
                                  uploaded:
                                      '${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.day.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.month.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.year.toString()}',
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
                                              BlocProvider.of<
                                                          CollectionBlocBloc>(
                                                      context)
                                                  .add(
                                                SendDownloadWallpaper(
                                                  id: data.id ?? "",
                                                  userId: UserPreferences
                                                      .getUserId(),
                                                  name: data.name ?? "",
                                                  category: data.category ?? "",
                                                  wallpaper:
                                                      data.wallpaper ?? "",
                                                ),
                                              );
                                              successSnackbar(
                                                  'wallpaper successfully downloaded!');
                                            }
                                          },
                                          child: Icon(
                                            Icons.file_download_outlined,
                                            size: 0.035.sh,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                        verticalSpace(0.02.sh),
                                        GestureDetector(
                                          onTap: () {
                                            if (userID.isEmpty) {
                                              Get.to(const LoginScreen());
                                            } else {
                                              BlocProvider.of<
                                                          CollectionBlocBloc>(
                                                      context)
                                                  .add(
                                                SendLikedWallpaper(
                                                  id: data.id ?? "",
                                                  userId: UserPreferences
                                                      .getUserId(),
                                                  name: data.name ?? "",
                                                  category: data.category ?? "",
                                                  wallpaper:
                                                      data.wallpaper ?? "",
                                                ),
                                              );
                                            }
                                          },
                                          child: Icon(
                                            isLiked
                                                ? Icons.favorite_rounded
                                                : Icons.favorite_border_rounded,
                                            color: isLiked
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
