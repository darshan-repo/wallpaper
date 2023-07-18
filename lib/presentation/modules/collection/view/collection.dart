import 'package:wallpaper/libs.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  static const String route = 'CollectionScreen';

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  // AbstractWallpaper? abstractWallpaperData;
  bool loading = false;

  // @override
  // void initState() {
  //   getAbstractWallpaperData();
  //   super.initState();
  // }
  //
  // getAbstractWallpaperData() async {
  //   loading = true;
  //   abstractWallpaperData = await NetworkApi.fetchAbsttractWallpaper();
  //   loading = false;
  //   setState(() {});
  // }

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
          loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.white,
                  ),
                )
              : Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          // await AppNavigation.shared.moveToCollectionViewScreen(
                          //   {
                          //     'collectionName': collection[index]
                          //         ['collectionName'],
                          //     'totalCollection': collection[index]
                          //         ['totalCollection'],
                          //   },
                          // );
                        },
                        child: Container(
                          margin: margin(
                              marginType: MarginType.bottom,
                              marginValue: 0.01.sh),
                          height: 0.19.sh,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(''
                                  // abstractWallpaperData!.data[index].wallpaper,
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
                                  '',
                                  // abstractWallpaperData!.data[index].category,
                                  style: myTheme.textTheme.titleLarge,
                                ),
                                verticalSpace(0.02.sh),
                                Text(
                                  '',
                                  style: myTheme.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
