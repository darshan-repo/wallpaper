import 'package:get/get.dart';
import 'package:wallpaper/libs.dart';
import 'package:wallpaper/presentation/common/shared_prefs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);
  static const route = 'BottomNavigationBarScreen';

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
                  AppNavigation.shared.moveToBottomNavigationBarScreen();
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
                  AppNavigation.shared.moveToFavoriteScreen();
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
                  AppNavigation.shared.moveToDownloadScreen();
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
                  AppNavigation.shared.moveToPrivacyPolicyScreen();
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
                  AppNavigation.shared.moveToReportAnIssueScreen();
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
                onTap: () {
                  Get.offAll(const LoginScreen());
                  UserPreferences().reset();
                },
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
                  style: TextStyle(color: ColorManager.white),
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
              child: GestureDetector(
                onTap: () {
                  AppNavigation.shared.moveToNotificationScreen();
                },
                child: const Icon(Icons.notification_important_outlined),
              ),
            )
          ],
        ),
        extendBody: true,
        body: NavigationScreen(screensList[activeIndex]),
        bottomNavigationBar: DotNavigationBar(
          marginR: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
