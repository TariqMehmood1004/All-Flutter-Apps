// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../colors/colors.dart';

class NotificationModel with ChangeNotifier {

  String? _subject;
  String? _message;

  String? get subject => _subject;
  String? get message => _message;

  void insertDooMessage(BuildContext context, String title, String message) async {

    _subject = subject;
    _message = message;

    User? user = FirebaseAuth.instance.currentUser;

    if(user != null)
    {
      String userRole = FirebaseFirestore.instance.collection('users').doc('userRole').toString();

      if(userRole == FirebaseFirestore.instance.collection('users').doc('userRole').toString())
      {
        FirebaseFirestore store = FirebaseFirestore.instance;
        CollectionReference collectionReference = store.collection("Doo_Message");

        DocumentReference documentReference = collectionReference.doc();
        debugPrint("doc creating");
        await documentReference.set(
            {
              'Subject': _subject,
              'Message': _message,
              'userId': user.uid,
            }
        );
        debugPrint("notification added.");
        showSnackBar(context, msg: "You have sent the message.");
      } else {
        debugPrint("notification not added.");
        showSnackBar(context, msg: "You did not sent the message");
      }
    }
    notifyListeners();
  }

  final _taskCollection = FirebaseFirestore.instance.collection('users');

  showNotifications(BuildContext context) {
    Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            "My Notifications",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
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

                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: AppColors.primary),
                          onPressed: (){},
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
    );
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
    notifyListeners();
  }

// Retrieve records from 'fyp_notifications' collection
  void retrieveNotifications() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('fyp_notifications').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Records found
        List<QueryDocumentSnapshot> documents = querySnapshot.docs;
        for (var document in documents) {
          Map<String, dynamic> notification = document.data() as Map<String, dynamic>;
          // Process each notification record
          String title = notification['FYP_Title'];
          String members = notification['Members'];
          String supervisor = notification['Supervisor'];
          String description = notification['description'];

          // TODO: Do something with the notification data
          debugPrint('Title: $title');
          debugPrint('Members: $members');
          debugPrint('Supervisor: $supervisor');
          debugPrint('Description: $description');
          debugPrint('----------------------------');
        }
      } else {
        // No records found
        debugPrint('No notifications found.');
      }
    } catch (error) {
      debugPrint('Error retrieving notifications: $error');
    }
  }

}