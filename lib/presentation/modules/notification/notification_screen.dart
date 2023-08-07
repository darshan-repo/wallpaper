import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isShow = false;

  @override
  void initState() {
    BlocProvider.of<NotificationBloc>(context).add(GetNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String userId = UserPreferences().getUserId();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.09.sh,
        elevation: 0,
        backgroundColor: ColorManager.primaryColor,
        leadingWidth: 0,
        leading: const Text(''),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.notifications,
              style: myTheme.textTheme.titleLarge,
            ),
            verticalSpace(0.01.sh),
            Text(
              AppString.notificationsDesc,
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
      body: userId.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ImageAssetManager.noNotificationFound,
                    height: 0.25.sh,
                    width: 0.8.sw,
                  ),
                  Text(
                    AppString.oopsNoNotificationsRightNow,
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
          : BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return const CustomLoader();
                } else if (state is NotificationLoaded) {
                  return Padding(
                    padding: padding(
                        paddingType: PaddingType.all, paddingValue: 0.02.sh),
                    child: BlocProvider.of<NotificationBloc>(context)
                            .getNotificationModel!
                            .notificationData!
                            .isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  ImageAssetManager.noNotificationFound,
                                  height: 0.25.sh,
                                  width: 0.8.sw,
                                ),
                                Text(
                                  AppString.oopsNoNotificationsRightNow,
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
                                        const Rect.fromLTWH(
                                            100.0, 0.0, 180.0, 70.0),
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                      color: ColorManager.secondaryColor),
                              itemCount:
                                  BlocProvider.of<NotificationBloc>(context)
                                      .getNotificationModel!
                                      .notificationData!
                                      .length,
                              itemBuilder: (context, index) {
                                final data =
                                    BlocProvider.of<NotificationBloc>(context)
                                        .getNotificationModel!
                                        .notificationData![index];
                                final image = data.wallpaper!.split("/").last;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.72.sw,
                                          child: Text(
                                            data.message!,
                                            style:
                                                myTheme.textTheme.labelMedium,
                                          ),
                                        ),
                                        verticalSpace(0.02.sh),
                                        Text(
                                          '${data.createdAt!.day.toString()}/${data.createdAt!.month.toString()}/${data.createdAt!.year.toString()}   ${data.createdAt!.hour.toString()}:${data.createdAt!.minute.toString()}',
                                          style: myTheme.textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.08.sh,
                                      width: 0.18.sw,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImageBuilder(
                                          url: BaseApi.imgUrl + image,
                                          builder: (image) => Container(
                                            color: ColorManager.secondaryColor,
                                            width: double.infinity,
                                            height: 0.19.sh,
                                            child: Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          placeHolder: const CustomLoader(),
                                          errorWidget: const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  );
                }
                return Container();
              },
            ),
    );
  }
}
