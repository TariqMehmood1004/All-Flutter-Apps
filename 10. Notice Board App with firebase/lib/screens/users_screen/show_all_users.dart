import 'package:app/colors/colors.dart';
import 'package:app/colors/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowAllUsers extends StatefulWidget {
  const ShowAllUsers({super.key});

  @override
  State<ShowAllUsers> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<ShowAllUsers> {

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
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0,),
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

                      return Container(
                        margin: const EdgeInsets.only(bottom: 2.0),
                        decoration: BoxDecoration(
                          color: generateRandomColor(),
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

