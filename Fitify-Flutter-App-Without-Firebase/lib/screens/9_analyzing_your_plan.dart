import 'dart:developer';

import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/10_right_nutrition_choices.dart';
import 'package:flutter/material.dart';

import '../widgets/loader_counter.dart';
import '../widgets/navigation_widget.dart';

class AnalyzingYourResultScreen extends StatefulWidget {
  const AnalyzingYourResultScreen({super.key});

  @override
  State<AnalyzingYourResultScreen> createState() =>
      _AnalyzingYourResultScreenState();
}

class _AnalyzingYourResultScreenState extends State<AnalyzingYourResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LoaderCounter(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigation.navigateTo(
                      context, const RightNutritionChoicesScreen());
                  log("Next to Nutrition screen");
                },
                child:
                    const Text("Press on counter to Next to Nutrition screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
