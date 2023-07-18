
// ignore_for_file: prefer_const_constructors

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UsersNavController extends StatefulWidget {
  const UsersNavController({super.key});

  @override
  State<UsersNavController> createState() => _UsersNavControllerState();
}

class _UsersNavControllerState extends State<UsersNavController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error retrieving users: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> users = snapshot.data!.docs;

            if (users.isEmpty) {
              return Text('No users found.');
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                // String userId = users[index].id;
                String userRole = users[index]['userRole'];
                String userEmail = users[index]['email'];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Dismissible(
                    key: Key(index.toString()),
                    background: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Icon(Icons.save_alt_outlined, color: AppColors.cardBGColor,),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        color: AppColors.paletteColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Icon(Icons.delete_outline, color: AppColors.cardBGColor,),
                    ),
                    onDismissed: (direction){
                      if(direction == DismissDirection.endToStart)
                      {
                        deleteUser(userEmail);
                      } else {
                        final snackBar = SnackBar(
                          backgroundColor: AppColors.snackBarBGColor3,
                          content: Text('${userEmail.toString()} is saved.', style: TextStyle(color: AppColors.white),),
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
                    },
                    child: ListTile(
                      splashColor: AppColors.buttonColor,
                      onLongPress: (){
                        // _deleteUser(userId);
                        deleteUser(userEmail);
                      },
                      title: Text(userEmail),
                      subtitle: Text('Role: $userRole'),
                      trailing: IconButton(
                        color: AppColors.cardBGColor,
                        splashColor: AppColors.primary,
                        splashRadius: 22.0,
                        onPressed: () {
                          debugPrint("Delete icon clicked.");
                        },
                        icon: Icon(MdiIcons.delete, color: AppColors.primary,),
                      ),
                      leading: Icon(MdiIcons.account),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteUser(String userEmail) async {
    try {
      // Delete user's data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(userEmail).delete();

      // Delete user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }

      // Show success message or perform any other necessary actions
      showSnackBar(msg: "$userEmail is deleted successfully!");
    } on FirebaseAuthException catch (e) {
      // Handle errors
      showSnackBar(msg: "Failed to delete user: ${e.code.toString()}");
    }
  }

  void showSnackBar({String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text('${msg.toString()}', style: TextStyle(color: AppColors.white),),
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

