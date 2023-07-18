// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/widgets/constants.dart';
import '../screens/home_screen/home_screen.dart';

class FirebaseServices {
  final dateTime = DateFormat.yMMMEd().format(DateTime.now()).toString();
  final id = DateTime.now().microsecondsSinceEpoch.toString();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserCredential?> signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Completer<UserCredential?> completer = Completer<UserCredential?>();

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential? userCredential =
          await auth.signInWithCredential(credential);
          completer.complete(userCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          log('Verification failed: ${e.code.toString()}');
          Constants.showSnackBar(context, msg: "Verification Failed: ${e.code.toString()}");
          completer.complete(null);
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = ''; // Replace with user input
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          UserCredential? userCredential =
          await auth.signInWithCredential(credential);
          completer.complete(userCredential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('Code auto-retrieval timed out');
          Constants.showSnackBar(context, msg: "Code auto-retrieval timed out");
          completer.complete(null);
        },
      );
    } on FirebaseAuthException catch (e) {
      log('Error signing in with phone number: $e');
      Constants.showSnackBar(context, msg: "Error signing in with phone number: ${e.code.toString()}");
      completer.complete(null);
    }

    return completer.future;
  }


  static Future<void> initializedApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  static Future<void> updateNote({
    required BuildContext context,
    required String collectionId,
    required String noteId,
    required String editedTitle,
    required String editedDescription,
    required String editedDateTime,
    bool isConnected = true,
  }) async {
    try {
      if (isConnected) {
        final CollectionReference notesCollection =
            FirebaseFirestore.instance.collection(collectionId);

        await notesCollection.doc(noteId).update({
          'title': editedTitle,
          'description': editedDescription,
          'dateTime': editedDateTime,
        });

        Constants.showSnackBar(context, msg: "Note saved");
      } else {
        Constants.showSnackBar(context, msg: "Internet connection failed");
      }
    } catch (error) {
      Constants.showSnackBar(context, msg: "Error updating note: $error");
    }
  }

  Future<void> createNotes(BuildContext context,
      {String? collectionName, String? title, String? description}) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user's phone number
      String? userPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;

      // Create a new document reference in the specified collection
      DocumentReference documentRef = firestore.collection(collectionName!).doc();

      // Create a map with the note details
      Map<String, dynamic> notes = {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'userPhoneNumber': userPhoneNumber,
      };

      // Add the note data to the Firestore document
      await documentRef.set(notes);

      Constants.showSnackBar(context, msg: 'Note added successfully!');
    } catch (e) {
      Constants.showSnackBar(context, msg: 'Error: $e');
    }
  }



  static deleteTask(BuildContext context, collectionName, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .delete();
      Constants.showSnackBar(context, msg: "Note deleted successfully.");
    } on FirebaseAuthException catch (e) {
      Constants.showSnackBar(context, msg: e.code.toString());
    }
  }





  Future<String> verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    String? verificationId;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification if the device automatically detects the OTP
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          log('Verification Failed: ${e.message}');
          Constants.showSnackBar(context,
              msg: "Verification Failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification ID to use in the next step
          verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout callback
          // You can handle the timeout logic here
        },
      );

      Constants.showSnackBar(context, msg: "Phone is verified");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // Handle any exceptions
      log('Error: $e');
      Constants.showSnackBar(context, msg: e.code.toString());
    }

    return verificationId.toString();
  }

  Future<UserCredential?> signInWithOTP(
      BuildContext context, String verificationId, String otp) async {
    try {
      // Create a PhoneAuthCredential with the verification ID and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Handle any exceptions
      log('Error: $e');
      Constants.showSnackBar(context, msg: e.code.toString());
      return null;
    }
  }
}
