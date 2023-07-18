
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors/contants.dart';

class AddNotifications extends StatefulWidget {
  const AddNotifications({super.key});

  @override
  State<AddNotifications> createState() => _AddTimeTableControllerState();
}

class _AddTimeTableControllerState extends State<AddNotifications> {


  final String _startTimeDateNow = DateFormat('E, d MMM yyy HH:mm:ss').format(DateTime.now()).toString();

  final _titleController = TextEditingController();
  final _topicAssignmentController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _deadlineTimeController = TextEditingController();
  final _courseNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _startTimeController.text = _startTimeDateNow;
    _deadlineTimeController.text = "";
  }


  Future<void> addAssignments(String title, String topicAssignment, String startTime, String deadlineTime, String courseName) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference in a "fypProjects" collection
      DocumentReference projectRef = firestore.collection('TeacherDB').doc();

      // Create a map with the project details
      Map<String, dynamic> data = {
        'Assignment_Title': title,
        'Start_Time': startTime,
        'Deadline_Time': deadlineTime,
        'Course_Name': courseName,
        'Assignment_Topic': topicAssignment,
      };

      // Add the project data to the Firestore document
      await projectRef.set(data);

      showSnackBar(context, msg: 'Assignment uploaded successfully!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, msg: e.code.toString());
    }
  }

  Future<void> addRoleBasedAssignments(String title, String topicAssignment, String startTime, String deadlineTime, String courseName) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Check the role of the current user
        DocumentSnapshot userSnapshot = await firestore.collection('users').doc(currentUser.uid).get();
        String role = userSnapshot.get('userRole');

        if (role == 'teacher' || role == 'Teacher' || role == 'teacher'.toUpperCase()  || role == 'teacher'.toLowerCase()) {
          // Create a new document reference in the "Assignments" collection
          DocumentReference assignmentRef = firestore.collection('TeacherDB').doc();

          // Create a map with the assignment details
          Map<String, dynamic> data = {
            'Assignment_Title': title,
            'Start_Time': startTime,
            'Deadline_Time': deadlineTime,
            'Course_Name': courseName,
            'Assignment_Topic': topicAssignment,
            'userRole': role,
          };

          // Add the assignment data to the Firestore document
          await assignmentRef.set(data);

          showSnackBar(context, msg: 'Assignment uploaded successfully!');
        } else {
          showSnackBar(context, msg: 'Only teachers can upload assignments.');
        }
      } else {
        showSnackBar(context, msg: 'User not logged in.');
      }
    } catch (e) {
      showSnackBar(context, msg: e.toString());
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
            height: MediaQuery.of(context).size.height * 0.5,
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
                    "Create Assignment".toUpperCase(),
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
                            labelText: "Assignment Title",
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
                          controller: _topicAssignmentController,
                          decoration: InputDecoration(
                            labelText: "Assignment Topic",
                            icon: const Icon(Icons.topic_outlined),
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
                          enabled: false,
                          controller: _startTimeController,
                          decoration: InputDecoration(
                            labelText: "Start Time",
                            icon: const Icon(Icons.access_time),
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
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _deadlineTimeController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "Deadline Time" //label text of field
                          ),
                          readOnly: true,  //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              // showSnackBar(context, msg: pickedDate.toString());

                              String formattedDate = DateFormat('E, d MMM yyy HH:mm:ss').format(pickedDate);

                              // showSnackBar(context, msg: formattedDate.toString());
                              //you can implement different kind of Date Format here according to your requirement
                              setState(() {
                                _deadlineTimeController.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              showSnackBar(context, msg: "Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _courseNameController,
                          decoration: InputDecoration(
                            labelText: "Course Name",
                            icon: const Icon(Icons.notes_outlined),
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
                addRoleBasedAssignments(
                  _titleController.text.trim(),
                  _topicAssignmentController.text.trim(),
                  _startTimeController.text.trim(),
                  _deadlineTimeController.text.trim(),
                  _courseNameController.text.trim(),
                );
                Timer(const Duration(milliseconds: 350), (){
                  Navigator.of(context).pop();
                });
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
                Text(_startTimeDateNow, style: TextStyle(fontSize: 10.0, color: AppColors.buttonColor2, fontWeight: FontWeight.w400),),
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
              'Add Assignment',
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
