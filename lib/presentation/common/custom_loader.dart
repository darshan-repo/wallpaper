import 'package:walper/libs.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/loader.json',
        height: 70,
        width: 70,
        repeat: false,
      ),
    );
  }
}
