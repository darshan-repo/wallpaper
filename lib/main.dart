import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wallpaper/libs.dart';
import 'package:wallpaper/logic/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:wallpaper/logic/collection_bloc/bloc/collection_bloc_bloc.dart';
import 'package:wallpaper/presentation/common/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CollectionBlocBloc>(
        create: (context) => CollectionBlocBloc(),
      ),
      BlocProvider<AuthBlocBloc>(
        create: (context) => AuthBlocBloc(),
      ),
    ],
    child: const WallPaper(),
  ));
}

class WallPaper extends StatelessWidget {
  const WallPaper({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          navigatorKey: NavigationUtilities.key,
          onGenerateRoute: onGenerateRoute,
          navigatorObservers: [routeObserver],
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
