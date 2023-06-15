

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';

class LikeWidget extends StatelessWidget {
  const LikeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                color: AppColors.prettyBlue.withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: () => debugPrint("liked"),
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.cardBGColor,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          "1.5k",
          style: TextStyle(
              color: AppColors.cardBGColor,
              fontWeight: FontWeight.w500,
            letterSpacing: .8,
          ),
        ),
      ],
    );
  }
}
