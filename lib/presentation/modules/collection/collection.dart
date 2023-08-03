import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    BlocProvider.of<CollectionBlocBloc>(context).add(GetWallpaper());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collections',
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.02.sh),
          BlocBuilder<CollectionBlocBloc, CollectionBlocState>(
            builder: (context, state) {
              if (state is CollectionLoading) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 0.3.sh),
                    const Center(
                      child: SpinKitCircle(color: ColorManager.white),
                    ),
                  ],
                );
              } else if (state is CollectionLoaded) {
                return Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: BlocProvider.of<CollectionBlocBloc>(context)
                          .getWallpaperModel
                          ?.categories
                          ?.length,
                      itemBuilder: (context, index) {
                        final image =
                            BlocProvider.of<CollectionBlocBloc>(context)
                                    .getWallpaperModel
                                    ?.categories![index]
                                    .background!
                                    .split("/")
                                    .last ??
                                "";
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              CollectionViewScreen(
                                categoriesData:
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                        .getWallpaperModel
                                        ?.categories?[index]
                                        .categoryDatas,
                                categoryName:
                                    BlocProvider.of<CollectionBlocBloc>(context)
                                            .getWallpaperModel
                                            ?.categories![index]
                                            .name ??
                                        "",
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 0.19.sh,
                            child: CachedNetworkImage(
                              imageUrl: BaseApi.imgUrl + image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                margin: margin(
                                    marginType: MarginType.bottom,
                                    marginValue: 0.01.sh),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  padding: padding(
                                      paddingType: PaddingType.left,
                                      paddingValue: 0.08.sw),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        BlocProvider.of<CollectionBlocBloc>(
                                                    context)
                                                .getWallpaperModel
                                                ?.categories![index]
                                                .name ??
                                            "",
                                        style: myTheme.textTheme.titleLarge,
                                      ),
                                      verticalSpace(0.02.sh),
                                      Text(
                                        '${BlocProvider.of<CollectionBlocBloc>(context).getWallpaperModel?.categories![index].categoryDatas!.length} wallpapers',
                                        style: myTheme.textTheme.labelMedium,
                                      ),
                                    ],
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
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
