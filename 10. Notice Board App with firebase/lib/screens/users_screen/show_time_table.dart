

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
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
               Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0), child: Align(alignment: Alignment.topLeft, child: Text(
                 "Other Lectures",
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
                          children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> task =
                            document.data() as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 2.0),
                              decoration: BoxDecoration(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
                                  title: Text(task['title'],
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  subtitle: Text(task['time'],
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              )
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
    );
  }
}
