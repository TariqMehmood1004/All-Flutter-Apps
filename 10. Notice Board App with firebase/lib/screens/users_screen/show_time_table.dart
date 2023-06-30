

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class ShowTimeTableScreen extends StatefulWidget {
  const ShowTimeTableScreen({super.key});

  @override
  State<ShowTimeTableScreen> createState() => _ShowTimeTableScreenState();
}

class _ShowTimeTableScreenState extends State<ShowTimeTableScreen> {
  final _taskCollection = FirebaseFirestore.instance.collection('TimeTableTasks');

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
            margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              "Activity",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
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
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> task =
                      document.data() as Map<String, dynamic>;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2.0),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ListTile(
                          title: Text(task['title'],
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                          subtitle: Text(task['time'],
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
