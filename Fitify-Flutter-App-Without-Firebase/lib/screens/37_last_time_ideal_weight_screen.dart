import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '38_prefer_in_your_plan_screen.dart';

class LastTimeIdealWeightScreen extends StatefulWidget {
  const LastTimeIdealWeightScreen({Key? key}) : super(key: key);

  @override
  State<LastTimeIdealWeightScreen> createState() =>
      _LastTimeIdealWeightScreenState();
}

class _LastTimeIdealWeightScreenState extends State<LastTimeIdealWeightScreen> {
  int selectedOption = 0;
  List<String> options = [
    "Less than a year ago",
    "1-2 years ago",
    "More than 2 years ago",
    "Never",
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              color: AppColors.transparent,
              child: Column(
                children: [
                  Text(
                    "When was the last time you were at your ideal weight?",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PreferInyourPlanScreen()));
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 25),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: selectedOption == index
                                  ? AppColors.lightWhite
                                  : AppColors.light,
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
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
