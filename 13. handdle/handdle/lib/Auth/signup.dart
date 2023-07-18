import 'package:flutter/material.dart';
import 'package:handdle/utils/colors.dart';
import 'package:get/get.dart';
import 'otp_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
final _formKey = GlobalKey<FormState>();

class _SignUpState extends State<SignUp> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();
  bool rememberMe = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.06),
            child: Column(
              children: [
                Image.asset("images/signup.png",height: size.height / 2.5),
                const Text("Create your Handdle account",style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
                SizedBox(height: size.height * 0.02,),
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
                            TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Phone Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 3),
                          borderRadius: BorderRadius.circular(30)
                      ),
                    // border: InputBorder.none,
                    hintText: "62 853-4484-2849",
                    prefixIcon: const Icon(Icons.call,color: Colors.grey,),
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
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
                            TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: userName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 3),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    // border: InputBorder.none,
                    hintText: "Christen Wales",
                    prefixIcon: const Icon(Icons.call,color: Colors.transparent,),
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      rememberMe =! rememberMe;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(rememberMe ? Icons.check_box : Icons.check_box_outline_blank,color: primaryColor,),
                      SizedBox(width: size.width * 0.01,),
                      const Text("Remember me",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if (_formKey.currentState!.validate()){
                        Get.to(() => const OTPScreen());
                        /// connection
                      }
                    });
                  },
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: primaryColor
                    ),
                    child: const Text("Sign Up",textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}