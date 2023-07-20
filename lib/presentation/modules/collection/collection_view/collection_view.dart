import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/presentation/modules/set_wallpaper/set_wallpaper_screen.dart';

class CollectionViewScreen extends StatefulWidget {
  final String id;
  final String category;
  const CollectionViewScreen(
      {super.key, required this.id, required this.category});
  static const route = 'CollectionViewScreen';

  @override
  State<CollectionViewScreen> createState() => _CollectionViewScreenState();
}

class _CollectionViewScreenState extends State<CollectionViewScreen> {
  bool isLiked = false;

  List<int> likes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbar(
        context,
        actionIcon: Icons.filter_alt_outlined,
      ),
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
                    "${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data!.length.toString()} Wallpaper",
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
                            .getCollectionModel!
                            .data!
                            .length,
                        itemBuilder: (context, index) {
                          final image =
                              BlocProvider.of<CollectionBlocBloc>(context)
                                  .getCollectionModel!
                                  .data![index]
                                  .wallpaper
                                  ?.split("/")
                                  .last;
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                SetWallpaperScreen(
                                  imgURL: BaseApi.imgUrl + image,
                                  uploaded:
                                      '${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.day.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.month.toString()}/${BlocProvider.of<CollectionBlocBloc>(context).getCollectionModel!.data![index].createdAt!.year.toString()}',
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorManager.secondaryColor
                                    .withOpacity(0.5),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(BaseApi.imgUrl + image!),
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
                                        onTap: () {},
                                        child: Icon(
                                          Icons.file_download_outlined,
                                          size: 0.035.sh,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                      verticalSpace(0.02.sh),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isLiked = !isLiked;
                                          });
                                          if (isLiked == true) {
                                            likes.add(index);
                                          } else if (isLiked == false) {
                                            likes.remove(index);
                                          }
                                          print('===============>> $likes');
                                        },
                                        child: isLiked
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                color: ColorManager.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_rounded,
                                                color: ColorManager.white,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
