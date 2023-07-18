// ignore_for_file: use_build_context_synchronously
import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HandleUserAuth extends StatefulWidget {
  const HandleUserAuth({super.key});

  @override
  State<HandleUserAuth> createState() => _SignUpControllerState();
}

class _SignUpControllerState extends State<HandleUserAuth> {

  final _emailController = TextEditingController();
  final _userRollController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  void showSnackBar({String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text('Yay! ${msg.toString()}', style: TextStyle(color: AppColors.white),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  createUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String userRoll = _userRollController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    try {
      if(email == "" || password == "" || confirmPassword == "" || userRoll == "")
      {
        showSnackBar(msg: "Please fill all the required fields.");
      }
      else if(password != confirmPassword)
      {
        debugPrint("Passwords do not match!");
        showSnackBar(msg: "Passwords do not match!");
      } else {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;

        // Save user information to Firestore collection
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          'userRole': _userRollController.text.trim(),
          'email': _emailController.text.trim(),
        });

        showSnackBar(msg: "User created successfully.");
      }
    }
    on FirebaseAuthException catch(e){
      showSnackBar(msg: e.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        backgroundColor: AppColors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create new account".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      letterSpacing: 0.87,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextField(
                            controller: _userRollController,
                            decoration: InputDecoration(
                              labelText: "User Roll",
                              icon: const Icon(Icons.verified_user),
                              iconColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.0, fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 15.0),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              icon: const Icon(Icons.email),
                              iconColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.0, fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15.0),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              icon: const Icon(Icons.lock),
                              iconColor: AppColors.primary,
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 15.0),
                          TextField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                              ),
                              icon: const Icon(Icons.lock),
                              iconColor: AppColors.primary,
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 45.0),
                          InkWell(
                            onTap: () {
                              createUser();
                            },
                            child: Ink(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 150,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Icon(Icons.login, color: AppColors.primary,),
                                    Text("Create an Account", style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
