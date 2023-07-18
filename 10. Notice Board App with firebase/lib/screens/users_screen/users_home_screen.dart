

import 'package:app/colors/colors.dart';
import 'package:app/screens/users_screen/show_all_time_table_schedule.dart';
import 'package:app/screens/users_screen/show_all_users.dart';
import 'package:app/screens/users_screen/show_fyp.dart';
import 'package:app/screens/users_screen/show_notices.dart';
import 'package:app/screens/users_screen/show_time_table.dart';
import 'package:flutter/material.dart';

class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({super.key});

  @override
  State<UsersHomeScreen> createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            ShowTimeTableScreen(),
            SizedBox(height: 20.0,),
            showUserAssignments(),
            SizedBox(height: 20.0,),
            ShowUserFYP(),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}
