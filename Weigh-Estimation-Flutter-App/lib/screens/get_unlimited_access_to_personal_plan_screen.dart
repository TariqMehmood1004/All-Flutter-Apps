// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/statement_screens/get_bored_easily_statement_screen.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';
import 'daily_water_intake_screen.dart';

class GetUnlimitedAccessToPersonalPlanScreen extends StatefulWidget {
  const GetUnlimitedAccessToPersonalPlanScreen({Key? key}) : super(key: key);

  @override
  State<GetUnlimitedAccessToPersonalPlanScreen> createState() =>
      _GetUnlimitedAccessToPersonalPlanScreenState();
}

class _GetUnlimitedAccessToPersonalPlanScreenState
    extends State<GetUnlimitedAccessToPersonalPlanScreen> {
  bool isChecked = false;
  List<String> options = [
    "Monthly",
    "Yearly",
  ];

  List<String> prices = [
    "Rs 1,950",
    "Rs 13,400",
  ];

  List<String> discount = [
    "",
    "Rs 1,116.67/month",
  ];

  List<String> save = [
    "",
    "Save 42%!",
  ];

  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            log("Refreshed...");
          });
      // Perform your refresh logic here
    },
    child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.light,),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(400),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 25,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [
                          Color(0xFFEFEFEF),
                          Color(0xFFFFFFFF),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 2.0],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Get unlimited access to your personal plan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.black,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lose weight, get fit, build muscle, and more with carefully selected professional fitness plans and workouts personalized for you.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.black.withOpacity(0.4),
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.pexels.com/photos/927437/pexels-photo-927437.jpeg?auto=compress&cs=tinysrgb&w=1600',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                              for (int index = 0;
                                  index < options.length;
                                  index++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = index;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 30),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: selectedOption == index
                                          ? AppColors.white
                                          : AppColors.light,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (selectedOption == index)
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: AppColors.offGreen,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Icon(Icons.check_outlined,
                                                  size: 15,
                                                  color: AppColors.black),
                                            ),
                                          ),
                                        if (selectedOption != index)
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: AppColors.offGreen,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.light,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: AppColors.black
                                                      .withOpacity(0.5),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                options[index],
                                                style: TextStyle(
                                                  color: AppColors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 14,
                                                  fontFamily: "Segoe UI",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                prices[index],
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (selectedOption == index)
                                          Container(
                                            width: 150,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: AppColors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  discount[index],
                                                  style: TextStyle(
                                                    color: AppColors.black
                                                        .withOpacity(0.7),
                                                    fontSize: 14,
                                                    fontFamily: "Segoe UI",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: selectedOption ==
                                                                index &&
                                                            save[index]
                                                                .isNotEmpty
                                                        ? AppColors.blueAccent
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    save[index],
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 12,
                                                      fontFamily: "Segoe UI",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: myButton(context, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetBoredEasilyStatementScreen()));
                  },
                      title: "Subscribe",
                      foreColor: AppColors.black,
                      backgroundColor: AppColors.orange),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  child: InkWell(
                    onTap: () {
                      log("Restore Purchases");
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Restore ',
                        style: TextStyle(
                          color: AppColors.greyColor.withOpacity(0.5),
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Purchases',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Used by millions, personalized for you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 23,
                        fontFamily: "Segoe UI",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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

class ContainerItem {
  final String title;
  bool isChecked;

  ContainerItem({required this.title, this.isChecked = false});
}
