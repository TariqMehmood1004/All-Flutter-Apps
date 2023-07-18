
import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTimeTableController extends StatefulWidget {
  const AddTimeTableController({super.key});

  @override
  State<AddTimeTableController> createState() => _AddTimeTableControllerState();
}

class _AddTimeTableControllerState extends State<AddTimeTableController> {

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();

  final _taskTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final CollectionReference _taskCollection =
  FirebaseFirestore.instance.collection('TimeTableTasks');

  void _addTask() async {
    String title = _titleController.text.trim();
    String time = _timeController.text.trim();

    if (title.isNotEmpty && time.isNotEmpty) {
      try {
        await _taskCollection.add({
          'title': title,
          'time': time,
        });
        showSnackBar(msg: "Your task has been uploaded successfully.");
        _titleController.clear();
        _timeController.clear();
      } on FirebaseAuthException catch (e) {
        showSnackBar(msg: e.code.toString());
      }
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

  // Function to show the popup dialog
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBGColor,
          title: Text(
            'Add Task',
            style: TextStyle(
                color: AppColors.primary,
                fontWeight:
                FontWeight.bold,
                fontSize: 14.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Task Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _addTask,
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
                'Add Task',
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
