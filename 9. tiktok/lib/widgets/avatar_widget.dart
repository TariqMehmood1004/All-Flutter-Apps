

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final Map<String, dynamic> profile;
  const AvatarWidget({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () => debugPrint("Go to user's profile"),
          child: Container (
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBGColor, width: 2),

            ),
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage(
                 profile['avatar'],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => debugPrint("Follow"),
          child: CircleAvatar(
            backgroundColor: AppColors.blueBlack,
            radius: 15.0,
            child: Icon(
              Icons.add,
              color: AppColors.cardBGColor,
              size: 20.0,
            ),
          ),
        ),

      ],
    );
  }
}
