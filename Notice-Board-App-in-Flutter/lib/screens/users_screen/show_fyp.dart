import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowUserFYP extends StatefulWidget {
  const ShowUserFYP({super.key});

  @override
  State<ShowUserFYP> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<ShowUserFYP> {

  final _taskCollection = FirebaseFirestore.instance.collection('fypProjects');

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _membersController = TextEditingController();
  final _supervisorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _membersController.dispose();
    _supervisorController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
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
                    "Final Year Projects List",
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
                          return const Text('No tasks found.');
                        }

                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> task = document.data() as Map<String, dynamic>;
                              String title = task['FYP_Title'];
                              String description = task['Description'];
                              String members = task['Members'];
                              String supervisor = task['Supervisor'];

                              return Container(
                                padding: const EdgeInsets.all(8.0),
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
                                    title,
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
                                        "Description: $description",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Text(
                                        "Member(s): $members",
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Text(
                                        "Supervisor: $supervisor",
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

