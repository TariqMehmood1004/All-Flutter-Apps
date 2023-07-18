// ignore_for_file: prefer_const_constructors

import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/card_container.dart';
import '../widgets/navigation_widget.dart';
import '39_weight_screen.dart';

class PreferInyourPlanScreen extends StatefulWidget {
  const PreferInyourPlanScreen({super.key});

  @override
  State<PreferInyourPlanScreen> createState() => _PreferInyourPlanScreenState();
}

class _PreferInyourPlanScreenState extends State<PreferInyourPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
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
                "What pace would you prefer in your plan?",
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
                    title: "As fast as possible",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeightScreen()));
                    },
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(15.0),
                      child: InkResponse(
                        onTap: () {
                          Navigation.navigateTo(context, WeightScreen());
                        },
                        highlightShape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        containedInkWell: true,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.width * 0.06,
                              vertical: mq.width * 0.05),
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myTextWidget(
                                text: "Balanced pace",
                                fontSize: 14,
                                fontColor: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Arial",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: AppColors.blueAccent,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 17.5,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  myTextWidget(
                                    text: "Balanced pace",
                                    fontSize: 14,
                                    fontColor: AppColors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Arial",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  MyCardContainerWithoutImage(
                    title: "Slowly but steadily",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeightScreen()));
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
