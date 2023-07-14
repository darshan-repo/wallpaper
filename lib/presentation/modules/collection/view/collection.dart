import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

import 'collection_view/collection_view.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Map> collection = [
    {
      'collectionName': 'Abstract',
      'totalCollection': '1207 Wallpapers',
      'collectionImage': ImageJPGManager.abstractCollection,
    },
    {
      'collectionName': 'Architecture',
      'totalCollection': '643 Wallpapers',
      'collectionImage': ImageJPGManager.architectureCollection,
    },
    {
      'collectionName': 'Colorful',
      'totalCollection': '988 Wallpapers',
      'collectionImage': ImageJPGManager.colorfulCollection,
    },
    {
      'collectionName': 'Nature',
      'totalCollection': '2690 Wallpapers',
      'collectionImage': ImageJPGManager.natureCollection,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(
        paddingType: PaddingType.all,
        paddingValue: 0.02.sh,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collections',
            style: myTheme.textTheme.titleLarge,
          ),
          verticalSpace(0.02.sh),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                itemCount: collection.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CollectionViewScreen(
                          title: collection[index]['collectionName'],
                          desc: collection[index]['totalCollection'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: margin(
                        marginType: MarginType.bottom, marginValue: 0.01.sh),
                    height: 0.19.sh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage(
                          collection[index]['collectionImage'],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      padding: padding(
                          paddingType: PaddingType.left, paddingValue: 0.08.sw),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection[index]['collectionName'],
                            style: myTheme.textTheme.titleLarge,
                          ),
                          verticalSpace(0.02.sh),
                          Text(
                            collection[index]['totalCollection'],
                            style: myTheme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
