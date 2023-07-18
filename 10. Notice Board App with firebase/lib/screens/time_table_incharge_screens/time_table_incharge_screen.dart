
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';
import 'package:app/colors/colors.dart';
import 'package:app/email_auth/login_auth.dart';
import 'package:app/screens/solomon_bottom_bar.dart';
import 'package:app/screens/time_table_incharge_screens/add_time_table.dart';
import 'package:app/screens/time_table_incharge_screens/show_tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimeTableInchargeScreen extends StatefulWidget {
  const TimeTableInchargeScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableInchargeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TimeTableInchargeScreen> {

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

  var _currentIndex = 0;
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Perform any additional actions after logout
      Timer(const Duration(microseconds: 750), (){
        Navigator.pushReplacement(
            context, 
          MaterialPageRoute(builder: (context) => LoginController())
        );
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(msg: e.code.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        splashColor: AppColors.cardBGColor,
        backgroundColor: AppColors.buttonColor,
          focusElevation: 0,
          elevation: 0,
          onPressed: () {
            logout();
          },
        label: Text("Logout", style: TextStyle(color: AppColors.primary),),
      ),
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
              icon: const Icon(Icons.home),
              title: const Text("Home Page"),
              selectedColor: Colors.purple,
            ),


            SalomonBottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text("Add Time Table"),
              selectedColor: Colors.cyan ,
            ),

          ],
        ),
      ),
    );
  }

  List pages = [
    ShowAllTasks(),
    AddTimeTableController(),
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