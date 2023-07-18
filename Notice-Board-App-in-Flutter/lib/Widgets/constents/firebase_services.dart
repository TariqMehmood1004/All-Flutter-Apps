// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../colors/contants.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> createUserFirebaseServices(BuildContext context, String collectionName,String uid, String name, String email) async {
    try {
      // Create a new user document with the provided data
      await _firestore.collection(collectionName).doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'blocked': false,
        'friends': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
      showSnackBar( context, msg:'User created with $email');
    } catch (e) {
      // Handle any errors that occur during the insertion process
      showSnackBar( context, msg:'Error creating user document: $e');
    }
  }

  // Method to block/unblock a user by their UID
  Future<void> blockUser(BuildContext context, String userUid, bool blocked) async {
    String? currentUserUid = _auth.currentUser?.uid;

    // Get a reference to the current user's document
    DocumentReference currentUserRef = _firestore.collection('users').doc(currentUserUid);

    // Get a reference to the user that needs to be blocked/unblocked
    DocumentReference userToBlockRef = _firestore.collection('users').doc(userUid);

    // Start a batch operation for atomic writes
    WriteBatch batch = _firestore.batch();

    // Set the blocked status for the target user
    batch.update(userToBlockRef, {'blocked': blocked});

    // If blocking, remove the target user from the current user's friends list
    if (blocked) {
      batch.update(currentUserRef, {'friends': FieldValue.arrayRemove([userUid])});
      showSnackBar(context, msg: "User has been blocked!");
    } else {
      // If unblocking, add the target user back to the current user's friends list
      batch.update(currentUserRef, {'friends': FieldValue.arrayUnion([userUid])});
    }

    // Commit the batch operation
    await batch.commit();
  }

  Future<void> registerUserAccount(BuildContext context, String userRole, String userName, String email, String password) async {

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password:password,
      );

      // Get the UID of the registered user
      String? uid = userCredential.user?.uid;

      // Create the user document in Firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'userRole': userRole,
        'name': userName,
        'email': email,
        'blocked': false,
        'friends': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      showSnackBar(context, msg: '$email is created successfully.');

    } catch (e) {
      // Handle any errors that occur during the registration process
      showSnackBar(context, msg: 'Error registering user: $e');
      // Show error message to the user

    } finally {
      showSnackBar(context, msg: 'Loading error...');
    }
  }


  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<List<Map<String, dynamic>>> searchUsers(BuildContext context, String searchQuery) async {
    try {
      QuerySnapshot querySnapshot = await _usersCollection
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
          .get();

      List<Map<String, dynamic>> searchResults = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      showSnackBar(context, msg: searchResults.toString());
      return searchResults;
    } catch (e) {
      // Handle any potential errors here
      showSnackBar(context, msg: 'Error searching users: $e');
      return [];
    }
  }

}


