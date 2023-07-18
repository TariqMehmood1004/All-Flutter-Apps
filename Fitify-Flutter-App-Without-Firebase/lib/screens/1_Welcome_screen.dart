// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/widgets/my_button.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/card_container.dart';
import '2_body_type_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myTextWidget(
          text: "Welcome to Fitify",
          fontSize: 28,
          fontColor: AppColors.prettyOrange,
          fontWeight: FontWeight.bold,
          fontFamily: "Arial",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   alignment: Alignment.topLeft,
            //   margin: EdgeInsets.only(
            //       top: MediaQuery.of(context).size.height * 0.07,
            //       left: 20,
            //       right: 20),
            //   child: myTextWidget(
            //       text: "Welcome to Fitify.",
            //       fontSize: 30,
            //       fontColor: AppColors.prettyOrange,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: "Arial"),
            // ),
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: myTextWidget(
                  text: "What's your gender?",
                  fontSize: 25,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  MyCardContainer(
                    title: "Female",
                    radiusImage: 8,
                    imageUrl: "assets/images/body.png",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BodyTypeScreen()));
                    },
                  ),
                  MyCardContainer(
                    title: "Male",
                    imageUrl: "assets/images/img2.png",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BodyTypeScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "Non-binary",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BodyTypeScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "Prefer not to say",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BodyTypeScreen()));
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      log("already have an account?");
                    },
                    child: myTextWidget(
                      text: "Already have an account?",
                      fontFamily: "Arial",
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.3),
                    child: myButton(context, () {},
                        title: "Log In",
                        backgroundColor: AppColors.black,
                        foreColor: AppColors.light),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
