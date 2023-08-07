import 'package:walper/libs.dart';

errorSnackbar(String description) {
  Get.snackbar(
    AppString.oopsSomethingWentWrong,
    description,
    shouldIconPulse: true,
    colorText: Colors.white,
    backgroundColor: Colors.red,
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
  );
}

successSnackbar(String description) {
  Get.snackbar(
    AppString.successful,
    description,
    shouldIconPulse: true,
    colorText: Colors.white,
    backgroundColor: Colors.green,
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
  );
}

warningSnackbar(String description) {
  Get.snackbar(
    AppString.warning,
    description,
    shouldIconPulse: true,
    colorText: Colors.white,
    backgroundColor: Colors.orange,
    icon: const Icon(
      Icons.warning_amber_rounded,
      color: Colors.white,
    ),
  );
}
