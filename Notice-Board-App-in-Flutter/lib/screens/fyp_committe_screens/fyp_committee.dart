
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';
import 'package:app/colors/colors.dart';
import 'package:app/email_auth/login_auth.dart';
import 'package:app/screens/fyp_committe_screens/search.dart';
import 'package:app/screens/fyp_committe_screens/show_tasks.dart';
import 'package:app/screens/solomon_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'add_fyp.dart';

class FYPScreen extends StatefulWidget {
  const FYPScreen({Key? key}) : super(key: key);

  @override
  State<FYPScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FYPScreen> {

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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text("Noticed Board | FYP".toUpperCase(), style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600),),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.cardBGColor),
                ),
                onPressed: () {
                  Timer(const Duration(milliseconds: 750), (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginController())
                    );
                  });
                },
                child: Text("Login", style: TextStyle(color: AppColors.primary, fontSize: 12.0, fontWeight: FontWeight.w600),),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
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
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text("Add"),
              selectedColor: Colors.cyan ,
            ),


            SalomonBottomBarItem(
              icon: const Icon(Icons.search_outlined),
              title: const Text("Search"),
              selectedColor: Colors.purple,
            ),



          ],
        ),
      ),
    );
  }

  List pages = [
    ShowFYP(),
    AddFYPProject(),
    SearchFYP(),
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