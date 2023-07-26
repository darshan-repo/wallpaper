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
                      child:
                          CircularProgressIndicator(color: ColorManager.white),
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
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          BlocProvider.of<CollectionBlocBloc>(context).add(
                            GetCollection(
                              id: BlocProvider.of<CollectionBlocBloc>(context)
                                      .getWallpaperModel!
                                      .categories![index]
                                      .id ??
                                  "",
                              category:
                                  BlocProvider.of<CollectionBlocBloc>(context)
                                          .getWallpaperModel!
                                          .categories![index]
                                          .name ??
                                      "",
                            ),
                          );
                        },
                        child: Container(
                          margin: margin(
                              marginType: MarginType.bottom,
                              marginValue: 0.01.sh),
                          height: 0.19.sh,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: AssetImage(
                                ImageJPGManager.abstractCollection,
                              ),
                              fit: BoxFit.fill,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  BlocProvider.of<CollectionBlocBloc>(context)
                                          .getWallpaperModel
                                          ?.categories![index]
                                          .name ??
                                      "",
                                  style: myTheme.textTheme.titleLarge,
                                ),
                                verticalSpace(0.02.sh),
                                Text(
                                  '00 Wallpapers',
                                  style: myTheme.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
