
// ignore_for_file: use_build_context_synchronously

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors/contants.dart';

class DooAddNotifications extends StatefulWidget {
  const DooAddNotifications({super.key});

  @override
  State<DooAddNotifications> createState() => _AddTimeTableControllerState();
}

class _AddTimeTableControllerState extends State<DooAddNotifications> {

  final _taskTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final _titleController = TextEditingController();


  final _messageController = TextEditingController();

  Future<void> addNotifications(String title, String message) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference in a "fypProjects" collection
      DocumentReference projectRef = firestore.collection('DooNotifications').doc();

      // Create a map with the project details
      Map<String, dynamic> dooData = {
        'SUBJECT': title,
        'MESSAGE': message,
      };

      // Add the project data to the Firestore document
      await projectRef.set(dooData);

      showSnackBar(context, msg: 'Notification added successfully!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, msg: e.code.toString());
    }
  }
  final _formKey = GlobalKey<FormState>();

  // Function to show the popup dialog
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBGColor,
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  Text(
                    "Create Notification".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 0.87,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: "Subject",
                            icon: const Icon(Icons.subject_outlined),
                            iconColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0, fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            labelText: "Message",
                            icon: const Icon(Icons.message_outlined),
                            iconColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0, fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                addNotifications(
                  _titleController.text.trim(),
                  _messageController.text.trim(),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: AppColors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: AppColors.transparent,
            ),
            child: Column(
              children: [
                const SizedBox(height: 25.0,),
                Text("Today", style: TextStyle(color: AppColors.primary, fontSize: 18.0, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5.0,),
                Text(_taskTime, style: TextStyle(fontSize: 10.0, color: AppColors.buttonColor2, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              _showAddTaskDialog();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(
                  width: 1.0,
                  color: AppColors.color1,
                ),
              ), child: Text(
              'Add Notification',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../colors/colors.dart';
//
// class DooAddNotifications extends StatefulWidget {
//   const DooAddNotifications({super.key});
//
//   @override
//   State<DooAddNotifications> createState() => _AddNotificationsState();
// }
//
// class _AddNotificationsState extends State<DooAddNotifications> {
//
//   final _subject = TextEditingController();
//   final _message = TextEditingController();
//
//   void _insertNotifications(String subject, String message) async {
//
//     FirebaseFirestore.instance.collection("DooNotifications").doc(userRole).update(
//         {
//           'SUBJECT': _subject.text.trim(),
//           'MESSAGE': _message.text.trim(),
//         }
//     );
//
//     FirebaseFirestore store = FirebaseFirestore.instance;
//     CollectionReference collectionReference = store.collection("Doo_notifications");
//
//     DocumentReference documentReference = collectionReference.doc();
//
//     await documentReference.set(
//         {
//           'SUBJECT': _subject,
//           'MESSAGE': _message,
//         }
//     );
//     showSnackBar(msg: "You have assigned the Project '$_subject'");
//   }
//
//
//   void showSnackBar({String msg = "message"}) {
//     final snackBar = SnackBar(
//       backgroundColor: AppColors.snackBarBGColor3,
//       content: Text('Yay! ${msg.toString()}', style: TextStyle(color: AppColors.white),),
//       action: SnackBarAction(
//         label: 'Ok',
//         textColor: AppColors.white,
//         onPressed: () {
//           // Some code to undo the change.
//         },
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 50),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               "Add Notification".toUpperCase(),
//               style: TextStyle(
//                 fontSize: 30.0,
//                 letterSpacing: 0.87,
//                 color: AppColors.primary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _subject,
//                     decoration: InputDecoration(
//                       labelText: "Subject of the topic",
//                       icon: const Icon(Icons.title_outlined),
//                       iconColor: AppColors.primary,
//                       labelStyle: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 12.0, fontWeight: FontWeight.w300,
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.primary),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.primary),
//                       ),
//                     ),
//                     keyboardType: TextInputType.text,
//                   ),
//                   const SizedBox(height: 15.0),
//                   TextField(
//                     controller: _message,
//                     decoration: InputDecoration(
//                       labelText: "Message Notification",
//                       icon: const Icon(Icons.description_outlined),
//                       iconColor: AppColors.primary,
//                       labelStyle: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 12.0, fontWeight: FontWeight.w300,
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.primary),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.primary),
//                       ),
//                     ),
//                     keyboardType: TextInputType.multiline,
//                   ),
//
//                   const SizedBox(height: 45.0),
//                   InkWell(
//                     onTap: () {
//                       _insertNotifications(
//                           _subject.toString().trim(),
//                           _message.toString().trim()
//                       );
//                     },
//                     child: Ink(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width - 250,
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: AppColors.buttonColor,
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             // Icon(Icons.login, color: AppColors.primary,),
//                             Text("Add Notification", style: TextStyle(
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w600,
//                             ),),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
