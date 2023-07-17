import 'package:wallpaper/libs.dart';

class CollectionViewScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const CollectionViewScreen({super.key, required this.args});
  static const route = 'CollectionViewScreen';

  @override
  State<CollectionViewScreen> createState() => _CollectionViewScreenState();
}

class _CollectionViewScreenState extends State<CollectionViewScreen> {
  bool isSelect = true;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.args['collectionName'],
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.01.sh),
            Text(
              widget.args['totalCollection'],
              style: myTheme.textTheme.labelMedium,
            ),
            verticalSpace(0.01.sh),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(ImageJPGManager.yellowPinkColor),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.05),
                        ),
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = !isSelect;
                            });
                          },
                          child: Padding(
                            padding: padding(
                                paddingType: PaddingType.LTRB,
                                right: 0.01.sw,
                                bottom: 0.005.sh),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.file_download_outlined,
                                  color: ColorManager.white,
                                ),
                                verticalSpace(0.01.sh),
                                isSelect
                                    ? const Icon(
                                        Icons.favorite_border_rounded,
                                        color: ColorManager.white,
                                      )
                                    : const Icon(
                                        Icons.favorite_rounded,
                                        color: ColorManager.red,
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
        ),
      ),
    );
  }
}
