import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/home/view/home_widget.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});
  static const String route = 'HomeSreen';

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final List items = [
    'Recent',
    'Trending',
    'Exclusive',
  ];

  String? selectedValue = 'Trending';
  bool isSelectGrid = true;
  bool isSelect = true;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 0.0,
            leading: const Text(''),
            expandedHeight: 300,
            floating: true,
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
                  Container(
                    height: 0.2.sh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage(ImageJPGManager.seaSky),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  verticalSpace(0.009.sh),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 0.1.sh,
                        width: 0.29.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(ImageJPGManager.bananas),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 0.1.sh,
                        width: 0.29.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(ImageJPGManager.yellowPinkColor),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 0.1.sh,
                        width: 0.29.sw,
                        decoration: BoxDecoration(
                          color: const Color(0xFFffb38e),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+4',
                          style: myTheme.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                verticalSpace(0.03.sh),
                Row(
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
                    const Spacer(),
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
                                paddingValue: 0.003.sh,
                              ),
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
                verticalSpace(0.01.sh),
                isSelectGrid
                    ? Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: MasonryGridView.count(
                            controller: scrollController,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Container(
                                height: (index % 5 + 1) * 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(ImageJPGManager.seaSky),
                                  ),
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
                                ),
                              );
                            },
                          ),
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
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        ImageJPGManager.yellowPinkColor),
                                  ),
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
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
