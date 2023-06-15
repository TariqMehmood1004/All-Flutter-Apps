

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key}) : super(key: key);

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
                  onPressed: () => debugPrint("commented"),
                  icon: Icon(
                    Icons.comment_rounded,
                    color: AppColors.cardBGColor,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          "1.3M",
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
