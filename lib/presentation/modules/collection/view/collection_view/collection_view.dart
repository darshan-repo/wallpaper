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
                    return GestureDetector(
                      onTap: () {
                        AppNavigation.shared.moveToSetWallpaperScreen({
                          'img':
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgitwckhqakWVDzZFPu0kn80NvBP3xXbbuS94Jl0pgHNUEvrKZtNtB1nMkwBtwVL49kski81Xb8aDKonFKrlbM9eKR28R1hRbsn7W8W7wArqOGXjqZRp5Uioj8PbnJCWC8dbEshwFEY2ut_k5xU62D0eP7e0IxzxoR59pmi6Iq4TTSEcsdrmvq7Ywk3/w296-h640/BIKER.jpg'
                        });
                      },
                      child: Container(
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
                          child: Padding(
                            padding: padding(
                              paddingType: PaddingType.LTRB,
                              right: 0.01.sw,
                              bottom: 0.005.sh,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.file_download_outlined,
                                  size: 0.035.sh,
                                  color: ColorManager.white,
                                ),
                                verticalSpace(0.02.sh),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSelect = !isSelect;
                                    });
                                  },
                                  child: isSelect
                                      ? const Icon(
                                          Icons.favorite_border_rounded,
                                          color: ColorManager.white,
                                        )
                                      : const Icon(
                                          Icons.favorite_rounded,
                                          color: ColorManager.red,
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
        ),
      ),
    );
  }
}
