// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/suffer_from_knee_pain_screen.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';

import 'daily_water_intake_screen.dart';
import 'how_many_push_ups_can_you_do_screen.dart';

class CookAtHomeScreen extends StatefulWidget {
  const CookAtHomeScreen({Key? key}) : super(key: key);

  @override
  State<CookAtHomeScreen> createState() => _CookAtHomeScreenState();
}

class _CookAtHomeScreenState extends State<CookAtHomeScreen> {
  bool isChecked = false;
  List<String> options = [
    "Fast",
    "Easy",
    "Inexpensive",
    "To go",
    "Foodie",
  ];

  List<String> descriptions = [
    "Under 10 mins preparation",
    "Five ingredients or less",
    "Easier on your budget",
    "Container friendly",
    "Delicious and varied",
  ];

  int selectedOption = 0;

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
        //         child: Center(
        //           child: CountdownTimer(durationInSeconds: 20),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "What kind of food do you cook at home?",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int index = 0; index < options.length; index++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                });
                              },
                              child: Container(
                                width: double.infinity,
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          options[index],
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          descriptions[index],
                                          style: TextStyle(
                                            color: AppColors.black.withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ],
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

            const SizedBox(
              height: 10,
            ),
            myButton(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  DailyWaterIntakeScreen())); },
                title: "Continue",
                foreColor: AppColors.black,
            backgroundColor: AppColors.orange),

            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerItem {
  final String title;
  bool isChecked;

  ContainerItem({required this.title, this.isChecked = false});
}
