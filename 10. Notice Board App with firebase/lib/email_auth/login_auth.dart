import 'dart:async';

import 'package:app/colors/colors.dart';
import 'package:app/email_auth/signup_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/admin_screens/users_model.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
        )
    );
  }



  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<UsersModel>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary,
              ),
          ),
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
                  "Login".toUpperCase(),
                  style: TextStyle(
                    fontSize: 32.0,
                    letterSpacing: 0.87,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30.0),
               Consumer<UsersModel>(
                 builder: (context, value, Widget? child){
                   return  Form(
                       child: Column(
                         children: [
                           TextField(
                             controller: emailController,
                             decoration: InputDecoration(
                               labelText: "Email",
                               labelStyle: TextStyle(color: AppColors.primary, fontSize: 12.0, fontWeight: FontWeight.w300),
                               icon: const Icon(Icons.email),
                               iconColor: AppColors.primary,
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
                             controller: passwordController,
                             decoration: InputDecoration(
                               labelText: "Password",
                               labelStyle: TextStyle(color: AppColors.primary, fontSize: 12.0, fontWeight: FontWeight.w300),
                               icon: const Icon(Icons.lock),
                               iconColor: AppColors.primary,
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: AppColors.primary),
                               ),
                               focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: AppColors.primary),
                               ),
                             ),
                             obscureText: true,
                           ),
                           const SizedBox(height: 45.0),
                           InkWell(
                             onTap: () {
                               value.signIn(
                                   context,
                                   emailController.text.trim(),
                                   passwordController.text.trim(),
                               );
                             },
                             child: Ink(
                               child: Container(
                                 width: MediaQuery.of(context).size.width - 250,
                                 padding: const EdgeInsets.all(12.0),
                                 decoration: BoxDecoration(
                                   color: AppColors.color1,
                                   borderRadius: BorderRadius.circular(4.0),
                                 ),
                                 child: Center(child: Text("Login", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500),)),
                               ),
                             ),
                           ),
                           const SizedBox(height: 30.0),
                           InkWell(
                             onTap: () {
                               Timer(const Duration(milliseconds: 750), (){
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=> const SignUpController()));
                               });
                             },
                             splashColor: AppColors.transparent,
                             hoverColor: AppColors.transparent,
                             child: Text(
                               "Create an account?",
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
