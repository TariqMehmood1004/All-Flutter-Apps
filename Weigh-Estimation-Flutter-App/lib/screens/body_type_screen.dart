// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/goal_screen.dart';

import '../widgets/card_container.dart';
import '../widgets/countdown_timer.dart';

class BodyTypeScreen extends StatefulWidget {
  const BodyTypeScreen({super.key});

  @override
  State<BodyTypeScreen> createState() => _BodyTypeScreenState();
}

class _BodyTypeScreenState extends State<BodyTypeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                "What's your body type?",
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
                  MyCardContainer(title: "Hourglass", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => GoalScreen())); },),

                  MyCardContainer(title: "Rectangle", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => GoalScreen())); },),

                  MyCardContainer(title: "Rounded", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => GoalScreen())); },),

                  MyCardContainer(title: "Lightbulb", imageUrl: 'https://static.vecteezy.com/system/resources/previews/018/923/230/large_2x/woman-workout-fitness-and-exercises-png.png',
                    onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => GoalScreen())); },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
