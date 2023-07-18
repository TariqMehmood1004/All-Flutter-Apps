import 'package:app/Views/dashboard.dart';
import 'package:app/constants/custom_widgets/constant_widget.dart';
import 'package:flutter/material.dart';

void main() {
  setStatusBarColor(Colors.black38);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardController(),
    );
  }
}
