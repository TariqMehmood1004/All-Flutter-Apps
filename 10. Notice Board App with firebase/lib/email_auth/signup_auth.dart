// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app/colors/colors.dart';
import 'package:app/email_auth/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/admin_screens/users_model.dart';

class SignUpController extends StatefulWidget {
  const SignUpController({super.key});

  @override
  State<SignUpController> createState() => _SignUpControllerState();
}

class _SignUpControllerState extends State<SignUpController> {

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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersModel>(context, listen: false);
    debugPrint("build Scaffold");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          ),
        backgroundColor: AppColors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Text(
                  "SIGN UP".toUpperCase(),
                  style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 0.87,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
               const SizedBox(height: 30.0),
                Consumer<UsersModel>(
                  builder: (BuildContext context, value, Widget? child) {
                    debugPrint("build Consumer");
                    return Form(
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
                                // createUser();
                                value.createUser(
                                  context,
                                  _emailController.text.trim(),
                                  _userRollController.text.trim(),
                                  _passwordController.text.trim(),
                                  _confirmPasswordController.text.trim(),
                                );

                                setState(() {

                                });
                              },
                              child: Ink(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 250,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.buttonColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Icon(Icons.login, color: AppColors.primary,),
                                      Text("Sign up", style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            InkWell(
                              onTap: () {
                                Timer(const Duration(milliseconds: 750), () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> const LoginController()));
                                });
                              },
                              splashColor: AppColors.transparent,
                              hoverColor: AppColors.transparent,
                              child: Text(
                                "Already login?",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.secondary,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        )
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
