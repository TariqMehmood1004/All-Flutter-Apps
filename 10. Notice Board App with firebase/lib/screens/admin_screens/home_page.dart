import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<HomePage> {

  final _taskCollection = FirebaseFirestore.instance.collection('users');

  // Variables to store the task input values
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _deleteTask(String taskId) async {
    try {
      await _taskCollection.doc(taskId).delete();
      showSnackBar(msg: "Task deleted successfully.");
    } on FirebaseAuthException catch (e) {
      showSnackBar(msg: e.code.toString());
    }
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Users",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 5.0,),
                Text(
                  "Long press to hide/show the functionality",
                  style: TextStyle(
                    color: AppColors.offGreen,
                    fontWeight: FontWeight.w300,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0,),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: _taskCollection.snapshots(),
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
                      String userEmail = task['email'];
                      String userRole = task['userRole'];
                      bool isBlocked = task['isBlocked'] ?? false;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 2.0),
                        decoration: BoxDecoration(
                          color: isBlocked ? AppColors.offGreen : AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ListTile(
                          onLongPress: () {
                            isBlocked = !isBlocked;
                            blockUser(userEmail, isBlocked);
                            setState(() { });
                            showSnackBar(msg: "blocked $userEmail");
                          },
                          title: Text(
                            userEmail,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          subtitle: Text(
                            userRole,
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w300,
                              fontSize: 10.0,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                            onPressed: () {
                              _emailController.text = userEmail;
                              _roleController.text = userRole;
                              showModalBox(document.id);
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline, color: AppColors.primary),
                            onPressed: () => _deleteTask(document.id),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

