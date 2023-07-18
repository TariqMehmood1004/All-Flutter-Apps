import 'package:app/Widgets/constents/firebase_services.dart';
import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/contants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<HomePage> {

  // final _customGetCollection = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('users');

  // Variables to store the task input values
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _roleController = TextEditingController();

 FirebaseService firebaseService = FirebaseService();

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void showSnackBar({String msg = "message"}) {
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

  showModalBox(String userRole) {
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
                  'Edit User',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'User Name'),
                ),
                TextField(
                  controller: _roleController,
                  decoration: const InputDecoration(labelText: 'User Role'),
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
                        FirebaseFirestore.instance.collection("users").doc(userRole).update(
                            {
                              'email': _emailController.text.trim(),
                              'name': _userNameController.text.trim(),
                              'userRole': _roleController.text.trim()
                            }
                        );
                        showSnackBar(msg: "Successfully updated.");
                        Navigator.of(context).pop();
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
                        'Update',
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

  Future<void> blockUser(String userEmail, bool isBlocked) async {
    try {
      // Get the reference to the user document
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userEmail);

      // Update the 'isBlocked' field in Firestore
      await userRef.update({'isBlocked': isBlocked});
      showSnackBar(msg: 'User blocked $userEmail.');
    } on FirebaseAuthException catch (e) {
      // Handle any errors
      showSnackBar(msg: 'Error blocking user: ${e.code.toString()}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            padding: const EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Users",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 2.0,),
                      Text(
                        "Long press to block the users.",
                        style: TextStyle(
                          color: AppColors.offGreen,
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _collection.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text('No tasks found.');
                      }

                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> task = document.data() as Map<String, dynamic>;
                            String uid = task['uid'];
                            String userEmail = task['email'];
                            String userName = task['name'];
                            String userRole = task['userRole'];
                            bool isBlocked = task['blocked'];

                            return Container(
                                margin: const EdgeInsets.only(bottom: 2.0),
                                decoration: BoxDecoration(
                                  color: isBlocked ? AppColors.orange : AppColors.transparent,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child:  ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                    onLongPress: () {
                                      isBlocked =! isBlocked;
                                      // blockAccount(context, isBlocked, 'users', userEmail);
                                      firebaseService.blockUser(context, uid, isBlocked);
                                      setState(() { });
                                    },
                                    title: Text(
                                      userEmail,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Blocked: $isBlocked',
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Text(
                                          'User name: $userName',
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Text(
                                          'User role: $userRole',
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    leading: IconButton(
                                      icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                                      onPressed: () {
                                        _emailController.text = userEmail;
                                        _userNameController.text = userName;
                                        _roleController.text = userRole;
                                        showModalBox(document.id);
                                      },
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_outline, color: AppColors.primary),
                                      onPressed: () => deleteRecord(context, document.id, 'users'),
                                    ),
                                  ),
                                )
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

