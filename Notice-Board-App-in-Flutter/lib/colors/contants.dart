// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:app/email_auth/login_auth.dart';
import 'package:app/screens/crud_operations/searching_query.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Widgets/constents/firebase_services.dart';
import 'colors.dart';

Color generateRandomColorBorder() {
  Random random = Random();
  int r = random.nextInt(256); // Random value between 0 and 255 for red
  int g = random.nextInt(256); // Random value between 0 and 255 for green
  int b = random.nextInt(256); // Random value between 0 and 255 for blue
  return Color.fromARGB(120, r, g, b); // Return the generated color
}

Color generateRandomColor() {
  Random random = Random();
  int r = random.nextInt(256); // Random value between 0 and 255 for red
  int g = random.nextInt(256); // Random value between 0 and 255 for green
  int b = random.nextInt(256); // Random value between 0 and 255 for blue
  return Color.fromARGB(12, r, g, b); // Return the generated color
}

Future<void> logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Perform any additional actions after logout
    Timer(const Duration(microseconds: 750), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginController())
      );
    });
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, msg: e.code.toString());
  }
}

void showSnackBar(BuildContext context, {String msg = "message"}) {
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


Future<List<DocumentSnapshot>> searching(BuildContext context, String projectName, String fieldName, String searchQuery) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Perform the search query
    QuerySnapshot querySnapshot = await firestore
        .collection(projectName)
        .where(fieldName, isEqualTo: searchQuery)
        .get();
    showSnackBar(context, msg: querySnapshot.docs.toString());
    return querySnapshot.docs;
  } catch (e) {
    showSnackBar(context, msg: 'Error searching FYP projects: $e');
    return [];
  }
}


showModalBox(BuildContext context, String headTitle, TextEditingController queryController, String projectName, String fieldName) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColors.transparent,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: AppColors.cardBGColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20.0,),
              Text(
                headTitle,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 5.0,),
              TextField(
                controller: queryController,
                decoration: const InputDecoration(labelText: 'Type title'),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.color1,
                        ),
                      ), child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                     var result = searching(context, projectName, fieldName, queryController.text.trim());
                     showSnackBar(context, msg: result.toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.transparent,
                        ),
                      ), child: Text(
                      'Search',
                      style: TextStyle(
                        color: AppColors.cardBGColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


showModalBoxSearch(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColors.transparent,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppColors.cardBGColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20.0,),
              Text(
                "Search",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 5.0,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  onChanged: (String val){
                    FirebaseService().searchUsers(context, val);
                  },
                  controller: BottomSheetModel().searchController,
                  decoration: InputDecoration(
                    hintText: 'Search your query...',
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w300,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                  ),

                ),
              ),
              const SizedBox(height: 25.0,),

              const SearchScreen(),

            ],
          ),
        ),
      );
    },
  );
}


showQuickAlertBox(BuildContext context, QuickAlertType quickAlertType, String text) {
  QuickAlert.show(
    context: context,
    type: quickAlertType,
    text: text,
  );
}


void deleteRecord(BuildContext context, String id, String collectionName) async {
  try {
    final customGetCollection = FirebaseFirestore.instance.collection(collectionName);
    await customGetCollection.doc(id).delete();
    showSnackBar(context, msg: "$collectionName deleted successfully.");
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, msg: e.code.toString());
  }
}


Future<void> blockAccount(BuildContext context, bool isBlocked, String collectionName, String userEmail) async {
  try {
    // Get the reference to the user document
    DocumentReference userRef =
    FirebaseFirestore.instance.collection(collectionName).doc(userEmail);

    // Update the 'isBlocked' field in Firestore
    await userRef.update({'isBlocked': isBlocked});
    showSnackBar(context, msg: 'User blocked $userEmail.');
  } on FirebaseAuthException catch (e) {
    // Handle any errors
    showSnackBar(context, msg: 'Error blocking user: ${e.code.toString()}');
  }
}




class BottomSheetModel {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  Future<void> performSearch() async {
    // Get the search query from the text controller
    final String searchQuery = searchController.text;

    // Access the Firestore collection that contains the user data
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    // Perform the search query using Firestore
    QuerySnapshot querySnapshot = await usersCollection
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
        .get();

    // Clear the previous search results
    searchResults.clear();

    // Update the searchResults list with the search query results
    searchResults.addAll(querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}