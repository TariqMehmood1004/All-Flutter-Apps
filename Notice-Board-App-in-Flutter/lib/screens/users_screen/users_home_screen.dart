

import 'package:app/colors/colors.dart';
import 'package:app/screens/users_screen/show_fyp.dart';
import 'package:app/screens/users_screen/show_notices.dart';
import 'package:app/screens/users_screen/show_time_table.dart';
import 'package:flutter/material.dart';

import '../solomon_bottom_bar.dart';
import 'home_nav_page.dart';

class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({super.key});

  @override
  State<UsersHomeScreen> createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.bottomNavBGColor,
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() =>  _currentIndex = i),
          items: [

            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),


            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.timeline),
              title: const Text("Schedule"),
              selectedColor: Colors.purple,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.assignment_outlined),
              title: const Text("Assignments"),
              selectedColor: Colors.teal,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.folder_outlined),
              title: const Text("Projects"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  List pages = const [
    Home(),
    ShowTimeTableScreen(),
    showUserAssignments(),
    ShowUserFYP(),
  ];
}
