import 'package:app/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class UserInfoController extends StatefulWidget {
  const UserInfoController({super.key});

  @override
  State<UserInfoController> createState() => _UserInfoControllerState();
}

class _UserInfoControllerState extends State<UserInfoController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.accentColor,
      body: Text('User Info'),
    );
  }
}
