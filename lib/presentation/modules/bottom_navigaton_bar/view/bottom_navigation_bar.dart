import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/home/view/home_screen.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<DotNavigationBarItem> tabData = [
    DotNavigationBarItem(
      icon: const Icon(Icons.home),
      selectedColor: ColorManager.primaryColor,
    ),

    /// Likes
    DotNavigationBarItem(
      icon: const Icon(Icons.view_comfy),
      selectedColor: ColorManager.primaryColor,
    ),

    /// Search
    DotNavigationBarItem(
      icon: const Icon(Icons.search_sharp),
      selectedColor: ColorManager.primaryColor,
    ),

    /// Profile
    DotNavigationBarItem(
      icon: const Icon(Icons.settings),
      selectedColor: ColorManager.primaryColor,
    ),
  ];
  int activeIndex = 0;
  List<Widget> screensList = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: Image.asset(
          ImageAssetManager.logo,
          scale: 0.008.sh,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding:
                padding(paddingType: PaddingType.right, paddingValue: 0.035.sw),
            child: const Icon(Icons.notification_important_outlined),
          )
        ],
      ),
      extendBody: true,
      body: NavigationScreen(screensList[activeIndex]),
      bottomNavigationBar: DotNavigationBar(
        items: tabData,
        duration: Duration.zero,
        backgroundColor: ColorManager.secondaryColor,
        splashColor: ColorManager.transparentColor,
        currentIndex: activeIndex,
        dotIndicatorColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        onTap: (int index) => setState(() {
          activeIndex = index;
        }),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget currentPage;

  const NavigationScreen(this.currentPage, {super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.currentPage;
  }
}
