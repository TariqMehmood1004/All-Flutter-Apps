// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfields.dart';
import '37_last_time_ideal_weight_screen.dart';

class HowOldAreYouScreen extends StatefulWidget {
  const HowOldAreYouScreen({super.key});

  @override
  State<HowOldAreYouScreen> createState() => _HowOldAreYouScreenState();
}

class _HowOldAreYouScreenState extends State<HowOldAreYouScreen> {
  final nameController = TextEditingController();

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
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "How old are you?",
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
              child: Column(
                children: [
                  MyTextFields(
                    nameController: nameController,
                    hintText: '0',
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  myButton(context,
                      title: "Continue",
                      backgroundColor: Colors.orangeAccent, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LastTimeIdealWeightScreen()));
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
