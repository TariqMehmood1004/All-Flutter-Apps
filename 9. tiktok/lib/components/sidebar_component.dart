import 'package:flutter/material.dart';
import 'package:tiktok/widgets/avatar_widget.dart';
import 'package:tiktok/widgets/comment_widget.dart';
import 'package:tiktok/widgets/like_widget.dart';

class SideBarComponent extends StatelessWidget {
  final Map<String, dynamic> item;
  const SideBarComponent({Key? key, required this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20.0,
      top: 460.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
              child: AvatarWidget(
                profile: item['profile'],
              ),
          ),
          const Padding(
            padding:  EdgeInsets.only(bottom: 8.0),
            child: LikeWidget(),
          ),
          const Padding(
            padding:  EdgeInsets.only(bottom: 20.0),
            child: CommentWidget(),
          ),
        ],
      ),
    );
  }
}
