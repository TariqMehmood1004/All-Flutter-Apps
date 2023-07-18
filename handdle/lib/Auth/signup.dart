// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handdle/Home/home_screen.dart';
import 'package:handdle/firebase_services/firebase_services.dart';
import 'package:handdle/utils/colors.dart';

import '../utils/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static String phoneNumber = "";
  static String userName = "";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool rememberMe = true;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: size.height,
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.06),
                child: Column(
                  children: [
                    Image.asset(
                      "images/signup.png",
                      height: size.height / 2.5,
                    ),
                    const Text(
                      "Create your Handdle account",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Row(
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Phone Number'),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "62 853-4484-2849",
                        prefixIcon: const Icon(
                          Icons.call,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Row(
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Username'),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: "Christen Wales",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        log("tapped...");

                        SignUp.phoneNumber =
                            phoneNumberController.text.toString();
                        SignUp.userName = userNameController.text.toString();

                        if (SignUp.phoneNumber.isEmpty) {
                          Constants.snackBar(context, "Phone number required.");
                        } else if (SignUp.userName.isEmpty) {
                          Constants.snackBar(context, "User name required.");
                        } else {
                          await FirebaseServices()
                              .createUserWithPhoneNumber(
                            context: context,
                            userName: SignUp.userName,
                            phoneNumber: SignUp.phoneNumber,
                          )
                              .then((value) {
                            Constants.navigateTo(context, const HomeScreen());
                          });
                        }
                      },
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: primaryColor,
                        ),
                        child: const Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
