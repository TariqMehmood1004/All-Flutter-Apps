// ignore_for_file: prefer_const_constructors

import 'package:fitifyapp/colors/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/card_container.dart';
import '17_anything_you_want_to_exclude.dart';

class AnyWorkoutExperience extends StatefulWidget {
  const AnyWorkoutExperience({super.key});

  @override
  State<AnyWorkoutExperience> createState() => _AnyWorkoutExperienceState();
}

class _AnyWorkoutExperienceState extends State<AnyWorkoutExperience> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Any previous workout experience?",
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
              margin: const EdgeInsets.only(top: 2, left: 20, right: 20),
              child: Column(
                children: [
                  MyCardContainerWithoutImage(
                    title: "Yes, I workout regularly",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnythingExcludeScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "Yes, less than a year ago",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnythingExcludeScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "Yes, more than 1 year ago",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnythingExcludeScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "No, I don't have any",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnythingExcludeScreen()));
                    },
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
