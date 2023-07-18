// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';
import 'get_unlimited_access_to_personal_plan_screen.dart';

class ExcludeLoudExercisesScreen extends StatefulWidget {
  const ExcludeLoudExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExcludeLoudExercisesScreen> createState() => _ExcludeLoudExercisesScreenState();
}

class _ExcludeLoudExercisesScreenState extends State<ExcludeLoudExercisesScreen> {
  bool isChecked = false;
  List<String> options = [
    "Yes, exclude loud exercises",
    "Yes, limit loud exercises",
    "No, don't exclude loud exercises",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "If at home, should we exclude loud exercises?",
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
            const SizedBox(height: 5,),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                "Some exercises such as jumping jacks might disturb your neighbors or households members. You can change it in the future.",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: selectedOption == index ? AppColors.lightWhite : AppColors.light,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.circular(50)
                                          ),
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
            myButton(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  GetUnlimitedAccessToPersonalPlanScreen())); },
                title: "Continue",
                foreColor: AppColors.black,
            backgroundColor: AppColors.orange),

            const SizedBox(
              height: 50,
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
