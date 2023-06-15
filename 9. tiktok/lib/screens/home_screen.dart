

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';
import 'package:tiktok/common/widgets.dart';
import 'package:tiktok/components/feed/feed_component.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const List<Map<String, dynamic>> data = [
    {
      "profile" : {
        "username" : "Tariq Mehmood",
        "avatar": "assets/images/img-1.png"
      },
      "media": "assets/videos/video-1.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "1200",
      "commentCount" : "39"
    },
    {
      "profile" : {
        "username" : "Ali Ahmad",
        "avatar": "assets/images/img-2.jpg"
      },
      "media": "assets/videos/video-2.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "200",
      "commentCount" : "3"
    },
    {
      "profile" : {
        "username" : "Iqrash Khan",
        "avatar": "assets/images/img-3.png"
      },
      "media": "assets/videos/video-3.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "120",
      "commentCount" : "9"
    },
    {
      "profile" : {
        "username" : "Khan",
        "avatar": "assets/images/img-3.png"
      },
      "media": "assets/videos/video-4.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "200",
      "commentCount" : "39"
    },
    {
      "profile" : {
        "username" : "Ali Khan",
        "avatar": "assets/images/img-3.png"
      },
      "media": "assets/videos/video-5.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "1200",
      "commentCount" : "39"
    },
    {
      "profile" : {
        "username" : "Tallat Mehmood",
        "avatar": "assets/images/img-3.png"
      },
      "media": "assets/videos/video-6.mp4",
      "description":"The Web platform does not support dart:io, so avoid plugin. Using the constructor attempts.",
      "likeCount": "560",
      "commentCount" : "339"
    },
  ];

  @override
  void initState() {
    super.initState();
    systemChrome();
  }

  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        body: GestureDetector(
          onLongPress: () {
            debugPrint("Paused");
          },
          child: GestureDetector(
            onDoubleTap: () {
              debugPrint("Double liked");
            },
            child: PageView(
              scrollDirection: Axis.vertical,
              children: data.map((item) {
                return FeedComponent(item: item);
              }).toList(),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (value) {
            debugPrint(value.toString());
          },
          backgroundColor: AppColors.transparent,
          elevation: 0,
          unselectedItemColor: AppColors.white,
          selectedItemColor: AppColors.blueLight,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "Add",),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search",),
          ],
        ),
      ),
    );
  }
}
