import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '20_cook_at_home_screen.dart';

class SleepEveryNightScreen extends StatefulWidget {
  const SleepEveryNightScreen({Key? key}) : super(key: key);

  @override
  State<SleepEveryNightScreen> createState() => _SleepEveryNightScreenState();
}

class _SleepEveryNightScreenState extends State<SleepEveryNightScreen> {
  int selectedOption = 0;

  List<String> options = [
    "More than 8 hours",
    "7-8 hours",
    "6-7 hours",
    "Less than 6 hours",
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                color: AppColors.transparent,
                child: Column(
                  children: [
                    Text(
                      "How much do you sleep every night?",
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
                                            const CookAtHomeScreen()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
