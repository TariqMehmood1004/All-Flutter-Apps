
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../colors/colors.dart';

class HomeCommittee extends StatefulWidget {
  const HomeCommittee({super.key});

  @override
  State<HomeCommittee> createState() => _HomeCommitteeState();
}

class _HomeCommitteeState extends State<HomeCommittee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notices').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error retrieving notices');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> notices = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notices.length,
              itemBuilder: (context, index) {
                String noticeContent = notices[index]['content'];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  decoration: BoxDecoration(
                    color: AppColors.cardBGColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: ListTile(
                    title: Text(noticeContent, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12.0,),),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
