
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/colors/colors.dart';
import 'package:notes/firebase_services/firebase_services.dart';

class SignUpWithPhoneNumber extends StatefulWidget {
  const SignUpWithPhoneNumber({super.key});

  @override
  State<SignUpWithPhoneNumber> createState() => _SignUpWithPhoneNumberState();
}

class _SignUpWithPhoneNumberState extends State<SignUpWithPhoneNumber> {

  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FToast().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign up".toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.87,
                  ),
                ),
                const SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
                 child:  Form(
                     child: TextFormField(
                       keyboardType: TextInputType.number,
                       controller: _phoneNumberController,
                       decoration: InputDecoration(
                           hintText: "+1 234 4567 912",
                         hintStyle: const TextStyle(
                           color: Colors.grey,
                           fontSize: 14,
                           fontWeight: FontWeight.w500,
                         ),
                         prefixIcon: Icon(Icons.phone_android_outlined, size: 17.5, color: AppColors.primary,),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.blueAccent, width: 1.0),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: AppColors.black, width: 1.0),
                             borderRadius:BorderRadius.circular(5.0)),
                         ),
                       ),
                     ),
                 ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
                    child:  InkWell(
                      focusColor: AppColors.pink,
                      highlightColor: AppColors.pink,
                      splashColor: AppColors.blueAccent,
                      overlayColor: MaterialStatePropertyAll<Color>(AppColors.pink),
                      radius: 25.0,
                      onTap: (){
                        log("pressed");
                        PhoneAuth().verifyPhoneNumber(context, _phoneNumberController.text.trim());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Text("Sign in"),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
