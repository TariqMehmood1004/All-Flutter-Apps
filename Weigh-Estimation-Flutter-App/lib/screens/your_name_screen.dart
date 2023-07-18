// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/focus_screen.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';
import 'package:weigh_estimation_app/widgets/my_textfields.dart';
import '../widgets/countdown_timer.dart';

class YourNameScreen extends StatefulWidget {
  const YourNameScreen({super.key});

  @override
  State<YourNameScreen> createState() => _YourNameScreenState();
}

class _YourNameScreenState extends State<YourNameScreen> {

  final nameController = TextEditingController();


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
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "What's your name?",
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
                  MyTextFields(nameController: nameController, hintText: 'Name',),
                  SizedBox(height: 50,),
                  myButton(context, title: "Continue",
                      backgroundColor: Colors.orangeAccent, (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FocusScreen()));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
