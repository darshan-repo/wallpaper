// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/presentation/common/google_auth.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  String userID = UserPreferences.getUserId();

  @override
  void initState() {
    if (userID.isNotEmpty) {
      BlocProvider.of<CollectionBlocBloc>(context).add(
        GetLikedWallpaper(),
      );
    }
    super.initState();
  }

  List<DotNavigationBarItem> tabData = [
    DotNavigationBarItem(
      icon: SvgPicture.asset(SVGIconManager.home, color: ColorManager.white),
      selectedColor: ColorManager.primaryColor,
    ),
    DotNavigationBarItem(
      icon: SvgPicture.asset(SVGIconManager.collection,
          color: ColorManager.white),
      selectedColor: ColorManager.primaryColor,
    ),
    DotNavigationBarItem(
      icon: SvgPicture.asset(SVGIconManager.search, color: ColorManager.white),
      selectedColor: ColorManager.primaryColor,
    ),
    DotNavigationBarItem(
      icon: SvgPicture.asset(
        SVGIconManager.setting,
        color: ColorManager.white,
      ),
      selectedColor: ColorManager.primaryColor,
    ),
  ];
  int activeIndex = 0;
  List<Widget> screensList = [
    const HomeScreenInit(),
    const CollectionScreen(),
    const SearchScreen(),
    const SettingScreen(),
  ];

  final advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    String userID = UserPreferences.getUserId();
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
                  Get.offAll(const BottomNavigationBarScreen());
                },
                splashColor: ColorManager.transparentColor,
                leading: SvgPicture.asset(
                  SVGIconManager.home,
                  color: ColorManager.white,
                ),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  if (userID.isEmpty) {
                    warningSnackbar('User not found. please login to continue');
                  } else {
                    Get.offAll(const FavoriteScreen());
                  }
                },
                splashColor: ColorManager.transparentColor,
                leading: SvgPicture.asset(
                  SVGIconManager.favorite,
                  color: ColorManager.white,
                ),
                title: const Text('Favorites'),
              ),
              ListTile(
                onTap: () {
                  if (userID.isEmpty) {
                    warningSnackbar('User not found. please login to continue');
                  } else {
                    BlocProvider.of<CollectionBlocBloc>(context).add(
                      GetDownloadWallpaper(id: UserPreferences.getUserId()),
                    );
                    Get.offAll(const DownloadScreen());
                  }
                },
                splashColor: ColorManager.transparentColor,
                leading: SvgPicture.asset(
                  SVGIconManager.download,
                  color: ColorManager.white,
                ),
                title: const Text('Downloads'),
              ),
              ListTile(
                onTap: () {
                  Get.offAll(const PrivacyPolicyScreen());
                },
                splashColor: ColorManager.transparentColor,
                leading: SvgPicture.asset(
                  SVGIconManager.privacypolicy,
                  color: ColorManager.white,
                ),
                title: const Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  Get.offAll(const ReportAnIssueScreen());
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
                  setState(() {
                    if (userID.isNotEmpty) {
                      UserPreferences().reset();
                      Authentication.signOut(context: context);
                      BlocProvider.of<AuthBlocBloc>(context).add(
                        Logout(
                          email: UserPreferences.getUserEmail(),
                        ),
                      );
                    } else {
                      Get.offAll(() => const LoginScreen());
                    }
                  });
                },
                splashColor: ColorManager.transparentColor,
                leading: userID.isNotEmpty
                    ? SvgPicture.asset(
                        SVGIconManager.logout,
                        color: ColorManager.white,
                      )
                    : SvgPicture.asset(
                        SVGIconManager.login,
                        color: ColorManager.white,
                      ),
                title: userID.isNotEmpty
                    ? const Text('Logout')
                    : const Text('Log In'),
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
                  Get.to(const NotificationScreen());
                },
                child: SvgPicture.asset(
                  SVGIconManager.notification,
                  color: ColorManager.white,
                ),
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
          // dotIndicatorColor: Colors.white,
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
