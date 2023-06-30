

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowNoticesScreen extends StatefulWidget {
  const ShowNoticesScreen({super.key});

  @override
  State<ShowNoticesScreen> createState() => _ShowNoticesScreenState();
}

class _ShowNoticesScreenState extends State<ShowNoticesScreen> {


  final _taskCollection = FirebaseFirestore.instance.collection('notices');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                "Notices by DOO",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                    return const Text('No Notices found.');
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
                            color: AppColors.blueAccent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            title: Text(task['content'],
                              style: TextStyle(
                                color: AppColors.cardBGColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.0,
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
      ),
    );
  }
}
