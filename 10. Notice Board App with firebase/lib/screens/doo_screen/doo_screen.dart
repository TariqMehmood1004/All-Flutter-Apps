
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:app/colors/colors.dart';
import 'package:app/screens/solomon_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../colors/contants.dart';
import 'add_notifications.dart';
import 'home_notifications.dart';

class DOOScreen extends StatefulWidget {
  const DOOScreen({Key? key}) : super(key: key);

  @override
  State<DOOScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DOOScreen> {

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
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.23,
        backgroundColor: AppColors.black,
        onPressed: () {
          showModalBox(
            context,
            "Search the Notifications",
            _searchController,
            "DooNotifications",
            "SUBJECT"
          );
          _searchController.clear();
        },
        child: Icon(Icons.search_outlined, color: AppColors.cardBGColor,),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text("Noticed Board - DOO".toUpperCase(), style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600),),
              IconButton(
                color: AppColors.primary,
                splashColor: AppColors.color2,
                splashRadius: 22.0,
                onPressed: () {
                  logout(context);
                },
                icon: Icon(MdiIcons.logout, color: AppColors.primary,),
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
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),


            SalomonBottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text("Add"),
              selectedColor: Colors.cyan ,
            ),

          ],
        ),
      ),
    );
  }

  List pages = [
    DooHomeNotifications(),
    DooAddNotifications(),
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