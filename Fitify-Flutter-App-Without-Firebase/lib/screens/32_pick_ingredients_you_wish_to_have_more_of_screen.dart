// ignore_for_file: prefer_const_constructors

import 'package:fitifyapp/screens/33_good_start_screen.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/navigation_widget.dart';

class PickIngredientsScreen extends StatefulWidget {
  const PickIngredientsScreen({Key? key}) : super(key: key);

  @override
  State<PickIngredientsScreen> createState() => _PickIngredientsScreenState();
}

class _PickIngredientsScreenState extends State<PickIngredientsScreen> {
  bool isChecked = false;
  List<String> options = [
    "Broccoli",
    "Mushrooms",
    "Peas",
    "Zucchini",
    "Sweet potato",
    "Tomato",
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Pick ingredients you wish to have more of",
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
                                        ? AppColors.white
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
            Navigation.navigateTo(context, const GoodStartScreen());
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
