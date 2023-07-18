// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../screens/10_right_nutrition_choices.dart';
import 'card_container.dart';
import 'my_text_widget.dart';
import 'navigation_widget.dart';

class LoaderCounter extends StatefulWidget {
  const LoaderCounter({Key? key}) : super(key: key);

  @override
  _LoaderCounterState createState() => _LoaderCounterState();
}

class _LoaderCounterState extends State<LoaderCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _borderAnimation;
  int percentage =
      0; // Declare the percentage variable outside the build method

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Adjust the duration as needed
    )..addListener(() {
        setState(() {
          // Update the percentage value
          double animationValue = 1.0 - _animationController.value;
          percentage = (animationValue * 100).toInt();

          if (percentage == 35) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.56,
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          myTextWidget(
                            text: "Are you typically on your feet or"
                                " sitting most of the day?",
                            fontFamily: "Arial",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontColor: AppColors.black,
                          ),
                          const SizedBox(height: 25),
                          MyCustomCardContainer(
                            title: "Active",
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(height: 6),
                          MyCustomCardContainer(
                            title: "Seated",
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
      });
    _animationController.reverse(from: 1.0);
    _borderAnimation = Tween<double>(begin: 2.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5), // Adjust the interval as needed
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderSize = _borderAnimation.value * 3;

    return GestureDetector(
      onTap: () {
        if (percentage == 100) {
          Timer(const Duration(seconds: 2), () {
            Navigation.navigateTo(context, const RightNutritionChoicesScreen());
          });
          log("Next to Nutrition screen");
        }
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: borderSize),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            '$percentage%',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
