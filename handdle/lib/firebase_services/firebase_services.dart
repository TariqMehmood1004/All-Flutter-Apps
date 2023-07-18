// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:handdle/Auth/apis.dart';
import 'package:handdle/Home/home_screen.dart';
import 'package:handdle/models/chat_messages_model.dart';
import 'package:handdle/models/users_model.dart';
import 'package:handdle/utils/constants.dart';
import 'package:intl/intl.dart';

import '../Auth/otp_screen.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static User get currentUser => _auth.currentUser!;

  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static final userId = DateTime.now().microsecondsSinceEpoch.toString();

  static String timeStamp =
      DateFormat.yMMMEd().format(DateTime.now()).toString();

  static String dateTime =
      DateFormat.yMMMEd().format(DateTime.now()).toString();

  static final databaseRef = FirebaseDatabase.instance.ref("users");

  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc(currentUser.uid).get())
        .exists;
  }

  static Future<void> createUser(
      {String? userName, String? phoneNumber}) async {
    final userModel = ChatUserModel(
      id: currentUser.uid,
      name: userName!,
      about: 'Tariq Mehmood here..',
      phoneNumber: phoneNumber!,
      createdAt: time,
      lastActive: time,
      isOnline: true,
      pushToken: '',
    );

    await firestore
        .collection('users')
        .doc(currentUser.uid)
        .set(userModel.toJson());
  }

  Future<void> createUserWithPhoneNumberWithRealTimeDatabase(
      {BuildContext? context, String? userName, String? phoneNumber}) async {
    try {
      // Send OTP to the provided phone number
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber!,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential);
          Constants.pushReplacementNavigateTo(context!, const HomeScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          Constants.showToast('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
          Constants.showToast('Verification code sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout for auto-retrieval of the OTP code
          Constants.showToast('Code retrieval timeout');
        },
      );

      // Save the user data in Firebase Realtime Database
      databaseRef.child(phoneNumber).set(
            ChatUserModel(
              id: phoneNumber,
              name: userName ?? "Please enter the user name",
              phoneNumber: phoneNumber,
              createdAt: time.toString(),
              lastActive: time.toString(),
              isOnline: true,
              pushToken: '',
            ).toJson(),
          );

      Constants.showToast('User created successfully!');
    } catch (e) {
      // Handle any errors that occur during the process
      Constants.showToast('Error creating user: $e');
    }
  }

  //
  //store data into realtime and then move to firestore.
  //
  Future<void> createUserWithPhoneNumber(
      {BuildContext? context, String? userName, String? phoneNumber}) async {
    try {
      // Send OTP to the provided phone number
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber!,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential);
          Constants.pushReplacementNavigateTo(context!, const HomeScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          Constants.showToast('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
          Constants.showToast('Verification code sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout for auto-retrieval of the OTP code
          Constants.showToast('Code retrieval timeout');
        },
      );

      // Save the user data in Firebase Realtime Database
      databaseRef.child(phoneNumber).set(
            ChatUserModel(
              id: phoneNumber,
              name: userName ?? "Please enter the user name",
              phoneNumber: phoneNumber,
              createdAt: time.toString(),
              lastActive: time.toString(),
              isOnline: true,
              pushToken: '',
            ).toJson(),
          );

      // Save the user data in Firestore
      FirebaseFirestore.instance.collection('users').doc(phoneNumber).set(
            ChatUserModel(
              id: phoneNumber,
              name: userName ?? "Please enter the user name",
              phoneNumber: phoneNumber,
              createdAt: time.toString(),
              lastActive: time.toString(),
              isOnline: true,
              pushToken: '',
            ).toJson(),
          );

      Constants.showToast('User created successfully!');
    } catch (e) {
      // Handle any errors that occur during the process
      Constants.showToast('Error creating user: $e');
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      // Phone authentication successful
      Constants.showToast('Phone authentication successful');
    } catch (e) {
      // Handle authentication failure
      Constants.showToast('Phone authentication failed: $e');
    }
  }

  // get conversation id
  static String getConversationId(String id) =>
      currentUser.uid.hashCode <= id.hashCode
          ? '${currentUser.uid}_$id'
          : '${id}_${currentUser.uid}';

  // get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUserModel userModel) {
    return FirebaseFirestore.instance
        .collection('chats/${getConversationId(userModel.id)}/messages/')
        .snapshots();
  }

  // get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatMessages() {
    return APIs.firestore.collection('messages').snapshots();
  }

  static Future<void> sendMessage(
      ChatUserModel userModel, String message) async {
    final MessagesModel messagesModel = MessagesModel(
      fromId: currentUser.uid,
      toId: userModel.id,
      msg: message,
      sentTime: time,
      readTime: '',
      type: Type.text,
    );

    final ref = FirebaseFirestore.instance
        .collection('chats/${getConversationId(userModel.id)}/messages/');

    await ref.doc(time).set(messagesModel.toJson());
  }

  // get user info for current user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUserModel userModel) {
    return APIs.firestore
        .collection('users')
        .where('id', isEqualTo: userModel.id)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    await APIs.firestore.collection('users').doc(APIs.currentUser.uid).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().microsecondsSinceEpoch.toString(),
    });
  }
}
