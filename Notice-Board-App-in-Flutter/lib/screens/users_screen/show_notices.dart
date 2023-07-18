// ignore_for_file: camel_case_types

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../colors/contants.dart';


class showUserAssignments extends StatefulWidget {
  const showUserAssignments({super.key});

  @override
  State<showUserAssignments> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<showUserAssignments> {

  final _taskCollection = FirebaseFirestore.instance.collection('TeacherDB');

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _assignmentTopController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _deadlineTimeController = TextEditingController();
  final _courseNameController = TextEditingController();
  final String _startTimeDate = DateFormat('E, d MMM yyy HH:mm:ss').format(DateTime.now()).toString();

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
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0), child: Align(alignment: Alignment.topLeft, child: Text(
                    "Assignments",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),),),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
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
                              String title = task['Assignment_Title'];
                              String topic = task['Assignment_Topic'];
                              String startTime = task['Start_Time'];
                              String deadline = task['Deadline_Time'];
                              String courseName = task['Course_Name'];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    topic,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6.0,),
                                      Text(
                                        "Assignment: $title",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 6.0,),
                                      Text(
                                        "Start Time: $startTime",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 6.0,),
                                      Text(
                                        "Deadline: $deadline",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 6.0,),
                                      Text(
                                        "Course Name: $courseName",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
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
              )
            ),
          ],
        ),
      ),
    );
  }
}

