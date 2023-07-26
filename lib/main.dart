import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walper/libs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await UserPreferences().init();
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
      ],
      child: const WallPaper(),
    ),
  );
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
        child: const GetMaterialApp(
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
