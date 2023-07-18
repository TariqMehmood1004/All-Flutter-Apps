
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/weight_screen.dart';
import 'package:weigh_estimation_app/screens/what_motivates_you_the_most_screen.dart';
import '../../widgets/countdown_timer.dart';
import 'fitness_tools_screen.dart';

class HowManyPushUpsScreen extends StatefulWidget {
  const HowManyPushUpsScreen({Key? key}) : super(key: key);

  @override
  State<HowManyPushUpsScreen> createState() => _HowManyPushUpsScreenState();
}

class _HowManyPushUpsScreenState extends State<HowManyPushUpsScreen> {
  int selectedOption = 0;
  List<String> options = [
    "30+",
    "15-29",
    "6-14",
    "Less than 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        // actions: [
        //   Stack(
        //     children: [
        //       Container(
        //         width: 25,
        //         height: 25,
        //         margin: const EdgeInsets.only(right: 30),
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(50),
        //         ),
        //         child: const Center(
        //           child: CountdownTimer(durationInSeconds: 20),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: AppColors.transparent,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "How many push-ups can you do?",
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int index = 0; index < options.length; index++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = index;
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  const WhatMotivatesYouTheMostScreen()));
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: selectedOption == index ? AppColors.white : AppColors.light,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  options[index],
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (selectedOption == index)
                                  Container(
                                    width: 17,
                                    height: 17,
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.offGreen,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
