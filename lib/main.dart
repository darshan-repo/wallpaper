import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';
import 'package:walper/presentation/common/notification_services.dart';

Future<void> myBackgroundHandler(RemoteMessage message) async {
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   Get.to(CustomerAndNotification(
  //     initselected: 0,
  //   ));
  // });
  return MyAppState()._showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CollectionBlocBloc>(
          create: (context) => CollectionBlocBloc(),
        ),
        BlocProvider<AuthBlocBloc>(
          create: (context) => AuthBlocBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider<PaginationBloc>(
          create: (context) => PaginationBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  requestingPermissionForIOS() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {}

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    requestingPermissionForIOS();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => selectNotification);
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data.isNotEmpty) MyAppState()._showNotification(message);
    });
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);

    notificationServices.getDeviceToken().then((value) {
      log("DEVICE TOKEN :::: $value");
      UserPreferences.setDeviceToken(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const GetMaterialApp(
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }

  Future _showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    Map<String, dynamic> data = message.data;

    AndroidNotification? android = message.notification?.android;
    // ignore: unnecessary_null_comparison
    if (data != null) {
      flutterLocalNotificationsPlugin.show(
        0,
        data['title'],
        data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android!.smallIcon,
          ),
          iOS: const DarwinNotificationDetails(
              presentAlert: true, presentSound: true),
        ),
        payload: 'Default_Sound',
      );
    }
  }

  void selectNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
