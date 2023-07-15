import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/presentation/common/buttons.dart';
import 'package:wallpaper/presentation/common/common_spaces.dart';
import 'package:wallpaper/presentation/modules/settings/view/update_profile/view/update_profile_widget.dart';
import 'package:wallpaper/presentation/resources/asset_manager.dart';
import 'package:wallpaper/presentation/resources/color_manager.dart';
import 'package:wallpaper/presentation/resources/theme_manager.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorManager.secondaryColor,
        elevation: 0,
        leading: Container(
          margin:
              margin(marginType: MarginType.LTRB, left: 0.04.sw, top: 0.02.sh),
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 0.1.sh,
                color: ColorManager.secondaryColor,
              ),
              Padding(
                padding: padding(
                    paddingType: PaddingType.LTRB, top: 0.04.sh, left: 0.35.sw),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(ImageJPGManager.userImage),
                ),
              ),
            ],
          ),
          verticalSpace(0.01.sh),
          Text(
            'Darshan Kikani',
            style: myTheme.textTheme.titleMedium,
          ),
          Text(
            '@darshan',
            style: myTheme.textTheme.displayMedium,
          ),
          verticalSpace(0.05.sh),
          profileRow(title: 'Phone', value: '25147 65983'),
          verticalSpace(0.05.sh),
          profileRow(title: 'Email', value: 'example@gmail.com'),
          verticalSpace(0.05.sh),
          profileRow(title: 'Location', value: 'India'),
          // verticalSpace(0.3.sh),
          Padding(
            padding: padding(
              paddingType: PaddingType.LTRB,
              left: 0.02.sw,
              right: 0.02.sw,
              top: 0.32.sh,
              bottom: 0.02.sh,
            ),
            child: materialButton(
              onPressed: () {},
              buttonColor: const Color.fromRGBO(255, 128, 147, 1),
              buttonText: 'Delete Account',
            ),
          )
        ],
      ),
    );
  }
}
