import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/32_pick_ingredients_you_wish_to_have_more_of_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/navigation_widget.dart';

class WhatMotivatesYouTheMostScreen extends StatefulWidget {
  const WhatMotivatesYouTheMostScreen({Key? key}) : super(key: key);

  @override
  State<WhatMotivatesYouTheMostScreen> createState() =>
      _WhatMotivatesYouTheMostScreenState();
}

class _WhatMotivatesYouTheMostScreenState
    extends State<WhatMotivatesYouTheMostScreen> {
  bool isChecked = false;
  List<String> options = [
    "Feeling confident",
    "Being active",
    "Improving sleeping",
    "Feeling happier",
    "Boosting energy",
    "Boosting immunity",
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
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "What motivates you the most?",
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 30),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(50),
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: BottomNavigationBarButton(
          onTap: () {
            Navigation.navigateTo(context, const PickIngredientsScreen());
          },
          backgroundColor: AppColors.orange,
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
