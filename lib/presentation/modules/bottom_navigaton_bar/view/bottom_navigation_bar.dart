import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/collection/view/collection.dart';
import 'package:wallpaper/presentation/modules/downloads/view/downloads_screen.dart';
import 'package:wallpaper/presentation/modules/favorites/view/favorite_screen.dart';
import 'package:wallpaper/presentation/modules/home/view/home_screen.dart';
import 'package:wallpaper/presentation/modules/privacy_policy/view/privacy_policy.dart';
import 'package:wallpaper/presentation/modules/report_an_issue/view/report_an_issue_screen.dart';
import 'package:wallpaper/presentation/modules/search/view/search_screen.dart';
import 'package:wallpaper/presentation/modules/settings/view/settings.dart';
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
    DotNavigationBarItem(
      icon: const Icon(Icons.view_comfy),
      selectedColor: ColorManager.primaryColor,
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.search_sharp),
      selectedColor: ColorManager.primaryColor,
    ),
    DotNavigationBarItem(
      icon: const Icon(Icons.settings),
      selectedColor: ColorManager.primaryColor,
    ),
  ];
  int activeIndex = 0;
  List<Widget> screensList = [
    const HomeScreen(),
    const CollectionScreen(),
    const SearchScreen(),
    const SettingScreen(),
  ];
  final advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.secondaryColor,
              ColorManager.secondaryColor.withOpacity(0.8),
            ],
          ),
        ),
      ),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      backdropColor: ColorManager.secondaryColor,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: ColorManager.white,
          iconColor: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 0.3.sw,
                height: 0.2.sh,
                margin: EdgeInsets.only(top: 24.0, bottom: 0.02.sh),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      ImageAssetManager.logo,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen(),
                    ),
                  );
                },
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.home,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteScreen(),
                    ),
                  );
                },
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.favorite,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Favorites'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DownloadScreen(),
                    ),
                  );
                },
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.download,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Downloads'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.privacyPolicy,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportAnIssueScreen(),
                    ),
                  );
                },
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.reportAnIssue,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Repost an issue'),
              ),
              verticalSpace(0.2.sh),
              ListTile(
                onTap: () {},
                splashColor: ColorManager.transparentColor,
                leading: Image.asset(
                  ImageAssetManager.logout,
                  color: ColorManager.white,
                  height: 0.035.sh,
                  width: 0.035.sh,
                ),
                title: const Text('Logout'),
              ),
              const Spacer(),
              Padding(
                padding: padding(
                    paddingType: PaddingType.bottom, paddingValue: 0.025.sh),
                child: const Text(
                  'Terms of Service | Privacy Policy',
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              advancedDrawerController.showDrawer();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Image.asset(
            ImageAssetManager.logo,
            scale: 0.008.sh,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: padding(
                  paddingType: PaddingType.right, paddingValue: 0.035.sw),
              child: const Icon(Icons.notification_important_outlined),
            )
          ],
        ),
        extendBody: true,
        body: NavigationScreen(screensList[activeIndex]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DotNavigationBar(
            backgroundColor: ColorManager.secondaryColor,
            splashColor: ColorManager.transparentColor,
            duration: Duration.zero,
            currentIndex: activeIndex,
            dotIndicatorColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            splashBorderRadius: 50,
            onTap: (int index) {
              setState(() {
                activeIndex = index;
              });
            },
            items: tabData,
          ),
        ),
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
