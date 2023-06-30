
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:app/colors/colors.dart';
import 'package:app/screens/admin_screens/handle_users.dart';
import 'package:app/screens/solomon_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TeacherScreen> {

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

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: Colors.pink,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text("Add"),
              selectedColor: Colors.cyan ,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.supervised_user_circle_sharp),
              title: const Text("Users"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  List pages = [
    Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notices').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error retrieving notices');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> notices = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notices.length,
              itemBuilder: (context, index) {
                String noticeContent = notices[index]['content'];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  decoration: BoxDecoration(
                    color: AppColors.cardBGColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: ListTile(
                    title: Text(noticeContent, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12.0,),),
                  ),
                );
              },
            );
          },
        ),
      ),
    ),

    SizedBox(
      child: Center(
        child: Text("Home Page", textAlign: TextAlign.center),
      ),
    ),

    SizedBox(
      child: Center(
        child: Text("Add Users", textAlign: TextAlign.center),
      ),
    ),

    SizedBox(
      child: Center(
        child: Text("Search Page", textAlign: TextAlign.center),
      ),
    ),

    HandleUserAuth(),

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