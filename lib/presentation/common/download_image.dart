import 'dart:developer';

import 'package:walper/libs.dart';
import 'package:http/http.dart' as http;

downloadAndSaveImageToGallery({required String imageUrl}) async {
  var response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    var imageData = Uint8List.fromList(response.bodyBytes);
    await ImageGallerySaver.saveImage(
      imageData,
      quality: 60,
      name: DateTime.now().toString(),
    );
    successSnackbar('Wallpaper successfully downloaded!');
  } else {
    log("Failed to load image: ${response.statusCode}");
  }
}
