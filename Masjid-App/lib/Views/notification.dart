import 'package:app/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class NotificationController extends StatefulWidget {
  const NotificationController({super.key});

  @override
  State<NotificationController> createState() => _NotificationControllerState();
}

class _NotificationControllerState extends State<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.accentColor,
      body: Text('Notifications'),
    );
  }
}
