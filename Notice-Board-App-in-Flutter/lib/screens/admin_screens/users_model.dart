
// ignore_for_file: avoid_web_libraries_in_flutter, use_build_context_synchronously
import 'dart:async';
import 'package:app/colors/colors.dart';
import 'package:app/email_auth/login_auth.dart';
import 'package:app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../doo_screen/doo_screen.dart';
import '../fyp_committe_screens/fyp_committee.dart';
import '../teacher_screens/teacher_screen.dart';
import '../time_table_incharge_screens/time_table_incharge_screen.dart';
import 'admin_screen.dart';

class UsersModel with ChangeNotifier {
  String? _email;
  String? _userRole;
  String? _password;
  String? _confirmPassword;

  String? get email => _email;
  String? get userRole => _userRole;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;

  createUser(BuildContext context, String email, String userRole, String password, String confirmPassword) async {
    _email = email;
    _userRole = userRole;
    _password = password;
    _confirmPassword = confirmPassword;

    try {
      if(email == "" || password == "" || confirmPassword == "" || userRole == "")
      {
        showSnackBar(context, msg: "Please fill all the required fields.");
      }
      else if(password != confirmPassword)
      {
        debugPrint("Passwords do not match!");
        showSnackBar(context, msg: "Passwords do not match!");
      } else {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;

        // Save user information to Firestore collection
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          'userRole': userRole,
          'email': email,
          'password': password,
        });

        showSnackBar(context, msg: "User created successfully.");
        Timer(const Duration(milliseconds: 750), (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginController())
          );
        }
        );
      }

    }
    on FirebaseAuthException catch(e){
      showSnackBar(context, msg: e.code.toString());
    }

    notifyListeners();
  }



  signIn(BuildContext context, String email, String password) async {
    try {
      _email = email;
      _password = _password;

      if(email == "" || password == "")
      {
        showSnackBar(context, msg: "Please fill all the required fields.");
      }
      else {
        UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;
        if(user != null)
        {
          // showSnackBar(msg: "User verified.");
          User? currentUser = FirebaseAuth.instance.currentUser;
          String userId = currentUser!.uid; // Use uid or email based on your user identification method

          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
          String userRole = userSnapshot['userRole'];
          bool isBlocked = userSnapshot['blocked'];

          if (userRole == 'FYP Head' || userRole == 'FYP' || userRole == 'fyp' || userRole == 'FYP Head'.toUpperCase() || userRole == 'FYP Head'.toLowerCase())  {
            Timer(const Duration(seconds: 1), (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const FYPScreen())
              );
            });
          } else if(userRole == 'DOO' || userRole == 'doo' || userRole == 'DoO' || userRole == 'DOO'.toUpperCase() || userRole == 'DOO'.toLowerCase())
          {
            Timer(const Duration(seconds: 1), (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const DOOScreen())
              );
            });
          }
          else if(userRole == 'Teacher' || userRole == 'teacher' || userRole == 'Teacher'.toUpperCase() || userRole == 'Teacher'.toLowerCase()) {
            if(isBlocked == false)
              {
                Timer(const Duration(milliseconds: 250), (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const TeacherScreen())
                  );
                });
              } else {
              showSnackBar(context, msg: "You have been blocked!");
            }

          }
          else if(userRole == 'Admin' || userRole == 'ADMIN' || userRole == 'admin' || userRole == 'admin'.toUpperCase() || userRole == 'admin'.toLowerCase()) {
            if(isBlocked == false)
            {
              Timer(const Duration(milliseconds: 250), (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AdminScreen())
                );
              });
            } else {
              showSnackBar(context, msg: "You have been blocked!");
            }
          }
          else if(userRole == 'time table' || userRole == 'Time Table Incharge' || userRole == 'Incharge' || userRole == 'Time Table Incharge'.toUpperCase() || userRole == 'Time Table Incharge'.toLowerCase()) {
            if(isBlocked == false)
            {
              Timer(const Duration(milliseconds: 250), (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const TimeTableInchargeScreen())
                );
              });
            } else {
              showSnackBar(context, msg: "You have been blocked!");
            }
          }
          else if(userRole == 'Student' || userRole == 'STUDENT' || userRole == 'student' || userRole == 'Student'.toUpperCase() || userRole == 'Student'.toLowerCase()) {
            if(isBlocked == false)
            {
              Timer(const Duration(milliseconds: 250), (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen())
                );
              });
            } else {
              showSnackBar(context, msg: "You have been blocked!");
            }
          }
          else {
            Timer(const Duration(milliseconds: 250), (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())
              );
            });
          }
        }
      }

    }
    on FirebaseAuthException catch(e)
    {
      debugPrint(e.code.toString());
      if(e.code.toString() == "wrong-password")
      {
        showSnackBar(context, msg: "Wrong password");
      }
      else if(e.code.toString() == "too-many-requests")
      {
        showSnackBar(context, msg: "You have attempted too many requests.");
      }
    }

    notifyListeners();
  }

  void showSnackBar(BuildContext context, {String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.light,
      elevation: 0.15,
      content: Text(msg.toString(), style: TextStyle(color: AppColors.primary),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.primary,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

}