import 'package:flutter/material.dart';

import '../../../resources/asset_manager.dart';

class PhotosSearchScreen extends StatefulWidget {
  const PhotosSearchScreen({super.key});

  @override
  State<PhotosSearchScreen> createState() => _PhotosSearchScreenState();
}

class _PhotosSearchScreenState extends State<PhotosSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImageJPGManager.yellowPinkColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
