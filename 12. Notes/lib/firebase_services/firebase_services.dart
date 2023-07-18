// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/home_screen/home_screen.dart';

import '../toast_message/toast_message.dart';

class PhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> verifyPhoneNumber(BuildContext context, String phoneNumber) async {

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

      ToastMessage().showSnackBar(context, msg: "Phone is verified");

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen()
        )
      );

    } on FirebaseAuthException catch (e) {
      // Handle any exceptions
      log('Error: $e');
      // ToastMessage().toastMessage(msg: e.code.toString());
      ToastMessage().showSnackBar(context, msg: e.code.toString());
    }

    return verificationId.toString();
  }

  Future<UserCredential?> signInWithOTP(BuildContext context, String verificationId, String otp) async {
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
      ToastMessage().showSnackBar(context, msg: e.code.toString());
      return null;
    }
  }
}
