// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/how_tall_are_you_screen.dart';

import '../widgets/card_container.dart';
import '../widgets/countdown_timer.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {Navigator.of(context).pop();},
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        // actions: [
        //   Stack(
        //     children: [
        //
        //       Container(
        //         width: 25,
        //         height: 25,
        //         margin: const EdgeInsets.only(right: 30),
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(50),
        //         ),
        //         child: Center(
        //           child: CountdownTimer(durationInSeconds: 20,),
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
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "What's your goal",
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
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  MyCardContainer(title: "Get toned", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HowTallAreYouScreen()));
                    },),
                  MyCardContainer(title: "Lose Weight", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HowTallAreYouScreen()));
                    },),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
