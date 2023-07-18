// ignore_for_file: prefer_const_constructors

import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/15_you_are_in_good_hands.dart';
import 'package:flutter/material.dart';

import '../widgets/card_container.dart';

class ReadyToCommitScreen extends StatefulWidget {
  const ReadyToCommitScreen({super.key});

  @override
  State<ReadyToCommitScreen> createState() => _ReadyToCommitScreenState();
}

class _ReadyToCommitScreenState extends State<ReadyToCommitScreen> {
  List<String> options = [
    "At least a year",
    "At least 3 months",
    "At least a months",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "For how long are you ready to commit?",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  MyCardContainerWithoutImage(
                    title: "At least a year",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodHandsScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "At least 3 months",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodHandsScreen()));
                    },
                  ),
                  MyCardContainerWithoutImage(
                    title: "At least a month",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodHandsScreen()));
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
