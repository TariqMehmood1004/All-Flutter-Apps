import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/app_colors.dart';
import 'package:tiktok/common/widgets.dart';
import 'package:tiktok/components/profile_component/profile_component.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  const VideoPlayerComponent({Key? key, required this.media}) : super(key: key);
  final String media;

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    systemChrome();

    _controller = VideoPlayerController.asset(widget.media)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }
  @override
  Widget build(BuildContext context) {
    final size = _controller.value.size;
    return _controller.value.isInitialized
        ? Container(
        decoration: BoxDecoration (
          color: AppColors.black2,
        ),
        width: size.width,
        height: size.height,
        child: VideoPlayer(_controller),
        ) : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
