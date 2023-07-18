
// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class CRUDProvider with ChangeNotifier {

  Future<void> deleteUserByEmail(BuildContext context, String userEmail) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;

    if (documents.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> document = documents.first;
      await document.reference.delete();
      showSnackBar(context, msg: "$userEmail is deleted successfully!");
    } else {
      showSnackBar(context, msg: "$userEmail did not deleted!");
    }
    notifyListeners();
  }


  void showSnackBar(BuildContext context, {String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text(msg.toString(), style: TextStyle(color: AppColors.white),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

}