import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:walper/libs.dart';

Future<void> downloadAndSaveImage(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      var path = await ExternalPath.getExternalStoragePublicDirectory(
          '${ExternalPath.DIRECTORY_DOWNLOADS}/walper');
      Directory dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create();
      }
      String imageName =
          "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
      final filePath = '${dir.path}/$imageName.png';
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } else {}
  } catch (e) {
    warningSnackbar('No Internet Connection');
  }
}
