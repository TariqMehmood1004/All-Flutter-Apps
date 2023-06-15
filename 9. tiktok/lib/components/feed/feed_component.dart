import 'package:flutter/material.dart';
import 'package:tiktok/components/profile_component/profile_component.dart';
import 'package:tiktok/components/sidebar_component.dart';
import 'package:tiktok/components/video_player_component.dart';

class FeedComponent extends StatefulWidget {
  const FeedComponent({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  State<FeedComponent> createState() => _FeedComponentState();
}

class _FeedComponentState extends State<FeedComponent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayerComponent(media: widget.item['media']),
        Positioned(
          bottom: 100.0,
            left: 20.0,
            right: 100.0,
            child: ProfileComponent(
              item: widget.item,
            ),
        ),
        Positioned(
          bottom: 100.0,
          left: 20.0,
          child: SideBarComponent(
            item: widget.item,
          ),
        ),
      ],
    );
  }
}
