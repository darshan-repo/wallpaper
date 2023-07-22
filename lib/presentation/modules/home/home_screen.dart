import 'package:walper/libs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List items = [
    'Recent',
    'Trending',
    'Exclusive',
  ];

  String? selectedValue = 'Trending';
  bool isSelectGrid = true;
  bool isSelect = false;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.01.sh),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 0.0,
              leading: const Text(''),
              expandedHeight: 0.45.sh,
              floating: true,
              pinned: true,
              backgroundColor: ColorManager.primaryColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Featured.',
                            style: myTheme.textTheme.titleLarge,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.white60,
                        ),
                        horizontalSpace(0.02.sw),
                        const Icon(
                          Icons.arrow_forward,
                          color: ColorManager.white,
                        ),
                      ],
                    ),
                    verticalSpace(0.03.sh),
                    conatiner(
                      height: 0.2,
                      width: double.infinity,
                      assetName: ImageJPGManager.seaSky,
                    ),
                    verticalSpace(0.009.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        conatiner(
                          height: 0.1,
                          width: 0.30,
                          assetName: ImageJPGManager.bananas,
                        ),
                        conatiner(
                          height: 0.1,
                          width: 0.30,
                          assetName: ImageJPGManager.yellowPinkColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const FeaturedScreen());
                          },
                          child: conatiner(
                            height: 0.1,
                            width: 0.30,
                            assetName: ImageJPGManager.bananas,
                            child: Container(
                              height: 0.1.sh,
                              width: 0.30.sh,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: Text(
                                '+99',
                                style: myTheme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                title: Container(
                  width: double.infinity,
                  padding: padding(
                      paddingType: PaddingType.vertical, paddingValue: 0.01.sh),
                  color: ColorManager.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dropDownButton(
                        selectedValue: selectedValue,
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: myTheme.textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        },
                      ),
                      Container(
                        padding: padding(
                          paddingType: PaddingType.LTRB,
                          left: 0.015.sw,
                          right: 0.015.sw,
                        ),
                        height: 0.05.sh,
                        decoration: BoxDecoration(
                          color: ColorManager.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectGrid = true;
                                });
                              },
                              child: Container(
                                padding: padding(
                                    paddingType: PaddingType.all,
                                    paddingValue: 0.003.sh),
                                width: 0.085.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  color: isSelectGrid
                                      ? const Color.fromRGBO(160, 152, 250, 1)
                                      : ColorManager.primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Image.asset(
                                  fit: BoxFit.contain,
                                  ImageAssetManager.grid,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                            horizontalSpace(0.02.sw),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectGrid = false;
                                });
                              },
                              child: Container(
                                padding: padding(
                                  paddingType: PaddingType.all,
                                  paddingValue: 0.003.sh,
                                ),
                                width: 0.085.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  color: isSelectGrid
                                      ? ColorManager.primaryColor
                                      : const Color.fromRGBO(160, 152, 250, 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Image.asset(
                                  fit: BoxFit.contain,
                                  ImageAssetManager.collection,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.all(0),
              ),
            ),
            isSelectGrid
                ? SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.to(
                          //   const SetWallpaperScreen(
                          //     imgURL:
                          //         'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgitwckhqakWVDzZFPu0kn80NvBP3xXbbuS94Jl0pgHNUEvrKZtNtB1nMkwBtwVL49kski81Xb8aDKonFKrlbM9eKR28R1hRbsn7W8W7wArqOGXjqZRp5Uioj8PbnJCWC8dbEshwFEY2ut_k5xU62D0eP7e0IxzxoR59pmi6Iq4TTSEcsdrmvq7Ywk3/w296-h640/BIKER.jpg',
                          //   ),
                          // );
                        },
                        child: homeGridview(
                          assetName: ImageJPGManager.seaSky,
                          downloadOnTap: () {},
                          height: (index % 5 + 1) * 100,
                          favoriteOnTap: () {
                            // setState(() {
                            //   isSelect = !isSelect;
                            // });
                          },
                          isSelect: isSelect,
                        ),
                      );
                    },
                  )
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: 15,
                        (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                const SetWallpaperScreen(
                                  uploaded: '',
                                  imgURL:
                                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgitwckhqakWVDzZFPu0kn80NvBP3xXbbuS94Jl0pgHNUEvrKZtNtB1nMkwBtwVL49kski81Xb8aDKonFKrlbM9eKR28R1hRbsn7W8W7wArqOGXjqZRp5Uioj8PbnJCWC8dbEshwFEY2ut_k5xU62D0eP7e0IxzxoR59pmi6Iq4TTSEcsdrmvq7Ywk3/w296-h640/BIKER.jpg',
                                ),
                              );
                            },
                            child: homeGridview(
                              assetName: ImageJPGManager.yellowPinkColor,
                              downloadOnTap: () {},
                              favoriteOnTap: () {
                                setState(() {
                                  isSelect = !isSelect;
                                });
                              },
                              isSelect: isSelect,
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
