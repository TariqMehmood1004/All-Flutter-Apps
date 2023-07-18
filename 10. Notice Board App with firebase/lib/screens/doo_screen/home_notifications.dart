import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import '../../colors/contants.dart';


class DooHomeNotifications extends StatefulWidget {
  const DooHomeNotifications({super.key});

  @override
  State<DooHomeNotifications> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<DooHomeNotifications> {

  final _taskCollection = FirebaseFirestore.instance.collection('DooNotifications');

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      showSnackBar(msg: "Project deleted successfully.");
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
                  'Edit Doo Notifications',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Message'),
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
                        FirebaseFirestore.instance.collection("DooNotifications").doc(userRole).update(
                            {
                              'SUBJECT': _titleController.text.trim(),
                              'MESSAGE': _descriptionController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              child: Text(
                "My Active Notifications",
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
                    return const Text('No data found.');
                  }

                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> task = document.data() as Map<String, dynamic>;
                        String subject = task['SUBJECT'];
                        String message = task['MESSAGE'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: generateRandomColor(),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            title: Text(
                              subject.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6.0,),
                                Text(
                                  "Description: \n$message",
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                            leading: IconButton(
                              icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                              onPressed: () {
                                _titleController.text = subject;
                                _descriptionController.text = message;
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
      ),
    );
  }
}

