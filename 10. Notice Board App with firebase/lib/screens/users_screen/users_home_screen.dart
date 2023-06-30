

import 'package:app/colors/colors.dart';
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
      child: const Column(
        children: [
          ShowTimeTableScreen(),
          ShowNoticesScreen(),
        ],
      ),
    );
  }
}
