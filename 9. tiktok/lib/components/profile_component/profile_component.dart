

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({Key? key, required this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        GestureDetector(
          onTap: () => debugPrint("Goto user's profile"),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("@${item['profile']['username']}",
              style: TextStyle(
                  color: AppColors.cardBGColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  letterSpacing: .7
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => debugPrint("show more"),
          child: Text(
            "${item['description']}",
            style: TextStyle(
              color: AppColors.cardBGColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              decoration: TextDecoration.none,
              height: 1.5,
              letterSpacing: .7,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
