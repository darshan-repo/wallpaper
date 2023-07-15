import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/font_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.09.sh,
        backgroundColor: ColorManager.primaryColor,
        leadingWidth: 0,
        leading: const Text(''),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.01.sh),
            Text(
              'Get the notification you need, when you need it.',
              style: myTheme.textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          Container(
            width: 0.115.sw,
            margin: margin(
              marginType: MarginType.LTRB,
              right: 0.04.sw,
              top: 0.017.sh,
              bottom: 0.017.sh,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorManager.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorManager.primaryColor,
      body: Padding(
        padding: padding(paddingType: PaddingType.all, paddingValue: 0.02.sh),
        child: isShow
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ImageAssetManager.noNotificationFound,
                    ),
                    Text(
                      'Oops ! No notifications right now.',
                      style: TextStyle(
                        fontSize: FontSize.s18,
                        fontFamily: FontFamily.roboto,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeightManager.semiBold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color.fromRGBO(160, 152, 250, 1),
                              Color.fromRGBO(175, 117, 112, 1),
                              Colors.yellow
                            ],
                          ).createShader(
                            const Rect.fromLTWH(100.0, 0.0, 180.0, 70.0),
                          ),
                      ),
                    )
                  ],
                ),
              )
            : NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New wallpapers Available',
                            style: myTheme.textTheme.titleMedium,
                          ),
                          verticalSpace(0.02.sh),
                          Text(
                            'Wed, 10 Jun 2020 12:39 PM',
                            style: myTheme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                      Container(
                        height: 0.08.sh,
                        width: 0.15.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.secondaryColor,
                          image: const DecorationImage(
                            image: AssetImage(ImageJPGManager.yellowPinkColor),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const Divider(color: ColorManager.secondaryColor),
                  itemCount: 15,
                ),
              ),
      ),
    );
  }
}
