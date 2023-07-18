import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:list_view_project/views/splash_screen_controller/splash_screen_controller.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Color(0xffffbf00),
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: const SplashScreen(),
    );
  }
}
