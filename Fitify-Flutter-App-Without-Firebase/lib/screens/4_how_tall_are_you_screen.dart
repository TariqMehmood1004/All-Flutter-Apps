// ignore_for_file: prefer_const_constructors

import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/5_your_name_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/radio_button.dart';

class HowTallAreYouScreen extends StatefulWidget {
  const HowTallAreYouScreen({super.key});

  @override
  State<HowTallAreYouScreen> createState() => _HowTallAreYouScreenState();
}

class _HowTallAreYouScreenState extends State<HowTallAreYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        // actions: [
        //   Stack(
        //     children: [
        //
        //       Container(
        //         width: 25,
        //         height: 25,
        //         margin: const EdgeInsets.only(right: 30),
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(50),
        //         ),
        //         child: Center(
        //           child: CountdownTimer(durationInSeconds: 20,),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "How tall are you?",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomRadioButton(),
                  SizedBox(
                    height: 30,
                  ),
                  myButton(context,
                      title: "Continue",
                      backgroundColor: Colors.orangeAccent, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YourNameScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
