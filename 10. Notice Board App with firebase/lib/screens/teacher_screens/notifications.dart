// ignore_for_file: camel_case_types

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class showAssignments extends StatefulWidget {
  const showAssignments({super.key});

  @override
  State<showAssignments> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<showAssignments> {
  final _taskCollection = FirebaseFirestore.instance.collection('TeacherDB');

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _assignmentTopController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _deadlineTimeController = TextEditingController();
  final _courseNameController = TextEditingController();
  final String _startTimeDate =
      DateFormat('E, d MMM yyy HH:mm:ss').format(DateTime.now()).toString();

  @override
  void dispose() {
    _titleController.dispose();
    _assignmentTopController.dispose();
    _startTimeController.dispose();
    _deadlineTimeController.dispose();
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimeController.text = _startTimeDate;
  }

  void _deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      showSnackBar(msg: "Assignment deleted successfully.");
    } on FirebaseAuthException catch (e) {
      showSnackBar(msg: e.code.toString());
    }
  }

  void showSnackBar({String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text(
        'Yay! ${msg.toString()}',
        style: TextStyle(color: AppColors.white),
      ),
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
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: AppColors.cardBGColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Edit Assignments',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: _titleController,
                  decoration:
                      const InputDecoration(labelText: 'Assignment Title'),
                ),
                TextField(
                  controller: _assignmentTopController,
                  decoration:
                      const InputDecoration(labelText: 'Assignment Topic'),
                ),
                TextField(
                  controller: _startTimeController,
                  decoration: const InputDecoration(labelText: 'Start Time'),
                  onChanged: (newTime) {
                    setState(() {
                      _startTimeController.text = newTime;
                    });
                  },
                ),
                TextField(
                  controller: _deadlineTimeController,
                  decoration: const InputDecoration(labelText: 'Deadline Time'),
                ),
                TextField(
                  controller: _courseNameController,
                  decoration: const InputDecoration(labelText: 'Course Name'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.color1,
                          ),
                        ),
                        child: Text(
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
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection("TeacherDB")
                            .doc(userRole)
                            .update({
                          'Assignment_Title': _titleController.text.trim(),
                          'Assignment_Topic':
                              _assignmentTopController.text.trim(),
                          'Start_Time': _startTimeController.text.trim(),
                          'Deadline_Time': _deadlineTimeController.text.trim(),
                          'Course_Name': _courseNameController.text.trim(),
                        });
                        showSnackBar(msg: "Successfully updated.");
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.transparent,
                          ),
                        ),
                        child: Text(
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
              margin:
                  const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 3.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Final Year Projects List",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _taskCollection.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            children:
                            snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> task =
                              document.data() as Map<String, dynamic>;
                              String title = task['Assignment_Title'];
                              String topic = task['Assignment_Topic'];
                              String startTime = task['Start_Time'];
                              String deadline = task['Deadline_Time'];
                              String courseName = task['Course_Name'];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    topic.toUpperCase(),
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        "Assignment \n$title",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        "Start Time: \n$startTime",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        "Deadline: \n$deadline",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        "Course Name: \n$courseName",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: IconButton(
                                    icon: Icon(Icons.edit_outlined,
                                        color: AppColors.primary),
                                    onPressed: () {
                                      _titleController.text = title;
                                      _assignmentTopController.text = topic;
                                      _startTimeController.text = startTime;
                                      _deadlineTimeController.text = deadline;
                                      _courseNameController.text = courseName;
                                      showModalBox(document.id);
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete_outline,
                                        color: AppColors.primary),
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

          ],
        ),
      ),
    );
  }
}
