
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';

import 'package:app/colors/colors.dart';
import 'package:app/screens/users_nav/users_nav.dart';
import 'package:app/screens/users_screen/users_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../email_auth/login_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference noticesCollection = FirebaseFirestore.instance.collection('notices');

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      )
    );
  }

  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text("Noticed Board".toUpperCase(), style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600),),
              IconButton(
                color: AppColors.primary,
                splashColor: AppColors.color2,
                splashRadius: 22.0,
                onPressed: () {
                  debugPrint("Menu icon clicked.");
                },
                icon: Icon(MdiIcons.menu, color: AppColors.primary,),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: (){
          Timer(const Duration(milliseconds: 750), (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginController())
            );
          });
        },
        child: Icon(Icons.login_rounded, color: AppColors.white, size: 20.0,),
      ),

    );
  }

  List pages = [
    UsersHomeScreen(),
    UsersNavController(),

  ];


  showSnackBar({String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text('Yay! ${msg.toString()}', style: TextStyle(color: AppColors.white),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}