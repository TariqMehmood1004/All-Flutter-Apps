
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../colors/colors.dart';

class DooAddNotifications extends StatefulWidget {
  const DooAddNotifications({super.key});

  @override
  State<DooAddNotifications> createState() => _AddNotificationsState();
}

class _AddNotificationsState extends State<DooAddNotifications> {

  final _subject = TextEditingController();
  final _message = TextEditingController();

  // void _insertNotifications(String subject, String message) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if(user != null)
  //   {
  //     String userRole = FirebaseFirestore.instance.collection('users').doc('userRole').toString();
  //
  //     if(userRole == FirebaseFirestore.instance.collection('users').doc('userRole').toString())
  //     {
  //       FirebaseFirestore store = FirebaseFirestore.instance;
  //       CollectionReference collectionReference = store.collection("Doo_notifications");
  //
  //       DocumentReference documentReference = collectionReference.doc();
  //
  //       await documentReference.set(
  //           {
  //             'SUBJECT': _subject,
  //             'MESSAGE': _message,
  //             'userId': user.uid,
  //           }
  //       );
  //       showSnackBar(msg: "You have assigned the Project '$_subject'");
  //     } else {
  //       showSnackBar(msg: "You did not assigned any notification.");
  //     }
  //   }
  // }

  void _insertNotifications(String subject, String message) async {

    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collectionReference = store.collection("Doo_notifications");

    DocumentReference documentReference = collectionReference.doc();

    await documentReference.set(
        {
          'SUBJECT': _subject,
          'MESSAGE': _message,
        }
    );
    showSnackBar(msg: "You have assigned the Project '$_subject'");
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Notification".toUpperCase(),
              style: TextStyle(
                fontSize: 30.0,
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
                    controller: _subject,
                    decoration: InputDecoration(
                      labelText: "Subject of the topic",
                      icon: const Icon(Icons.title_outlined),
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
                    controller: _message,
                    decoration: InputDecoration(
                      labelText: "Message Notification",
                      icon: const Icon(Icons.description_outlined),
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

                  const SizedBox(height: 45.0),
                  InkWell(
                    onTap: () {
                      _insertNotifications(
                          _subject.toString().trim(),
                          _message.toString().trim()
                      );
                    },
                    child: Ink(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 250,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.login, color: AppColors.primary,),
                            Text("Add Notification", style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
