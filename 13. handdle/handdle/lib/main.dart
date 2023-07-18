// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log(" ------ WidgetsFlutterBinding.ensureInitialized(); --------");

  await Firebase.initializeApp();
  log(" ------ await Firebase.initializeApp(); --------");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Handdle Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Scaffold(body: SignUp()),
      debugShowCheckedModeBanner: false,
    );
  }
}
