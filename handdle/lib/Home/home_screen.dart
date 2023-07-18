// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handdle/firebase_services/firebase_services.dart';
import 'package:handdle/models/users_model.dart';
import 'package:handdle/utils/colors.dart';

import 'home_pages/chats_home_page.dart';
import 'home_pages/following_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? _controller;

  final ref = FirebaseDatabase.instance.ref('users');
  final auth = FirebaseAuth.instance;

  // Query dbRef = FirebaseDatabase.instance.ref('users');

  List<ChatUserModel> userModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseServices.updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) {
      log("Message: $message");
      if (message.toString().contains('resume')) {
        FirebaseServices.updateActiveStatus(true);
      }
      if (message.toString().contains('pause')) {
        FirebaseServices.updateActiveStatus(false);
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {},
          label: Image.asset("images/message.png"),
          // child:
        ),
        appBar: AppBar(
          title: const Text(
            "Handdle",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  color: primaryColor,
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Add your search functionality here
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: primaryColor,
            labelStyle: const TextStyle(fontSize: 18),
            controller: _controller,
            tabs: const [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Following',
              ),
              Tab(
                text: 'Calls',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // chats_home_page.dart
            ChatsHomePage(),

            // following_home_page.dart
            FollowingHomePage(),

            // Contents of Tab 3
            Container(
              padding: EdgeInsets.all(size.width * 0.01),
              child: const Center(
                child: Text('Tab 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
