import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/statement_screens/41_feel_support_from_people_statement_screen.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/dot_container.dart';

class PlainReadyScreen extends StatefulWidget {
  const PlainReadyScreen({super.key});

  @override
  State<PlainReadyScreen> createState() => _PlainReadyScreenState();
}

class _PlainReadyScreenState extends State<PlainReadyScreen> {
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: myTextWidget(
                  text: "Your plan is ready!",
                  fontSize: 30,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 12,
                                      right: 16,
                                    ),
                                    child: Icon(Icons.work_outline),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        myTextWidget(
                                          text: "Goal",
                                          fontFamily: "Roboto",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontColor:
                                              AppColors.black.withOpacity(0.5),
                                        ),
                                        myTextWidget(
                                          text: "Lose weight",
                                          fontFamily: "Roboto",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 12,
                                      right: 16,
                                    ),
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        myTextWidget(
                                          text: "Duration",
                                          fontFamily: "Roboto",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontColor:
                                              AppColors.black.withOpacity(0.5),
                                        ),
                                        myTextWidget(
                                          text: "5 weeks",
                                          fontFamily: "Roboto",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: DotContainer(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const SizedBox(
                            width: 120,
                            height: 380,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/body.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 130,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.paletteColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: const Image(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/img10.jpeg"),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              width: 180,
                              height: 100,
                              decoration: BoxDecoration(
                                // color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.8),
                                    blurRadius: 25,
                                    spreadRadius: 20,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "10 - 15",
                                        style: TextStyle(
                                          color: AppColors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Minutes per workout",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontFamily: "Arial",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 130,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "4 Workouts",
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontFamily: "Arial",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Per week",
                                          style: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.45),
                                            fontSize: 13,
                                            fontFamily: "Arial",
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: [
                                      buildCrossTrueContainer(
                                        icon: Icons.cancel_outlined,
                                        iconColor:
                                            AppColors.black.withOpacity(0.3),
                                        backColor:
                                            AppColors.black.withOpacity(0.2),
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.check_outlined,
                                        iconColor: AppColors.black,
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.check_outlined,
                                        iconColor: AppColors.black,
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.cancel_outlined,
                                        iconColor:
                                            AppColors.black.withOpacity(0.3),
                                        backColor:
                                            AppColors.black.withOpacity(0.2),
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.check_outlined,
                                        iconColor: AppColors.black,
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.cancel_outlined,
                                        iconColor:
                                            AppColors.black.withOpacity(0.3),
                                        backColor:
                                            AppColors.black.withOpacity(0.2),
                                      ),
                                      buildCrossTrueContainer(
                                        icon: Icons.check_outlined,
                                        iconColor: AppColors.black,
                                      ),
                                    ],
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
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: myTextWidget(
                        text: "Inside the plan",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontColor: AppColors.primary,
                        fontFamily: "Arial",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  buildCrossTrueContainer(
                                    icon: Icons.check,
                                    iconColor: AppColors.black,
                                    backColor: AppColors.buttonColor,
                                  ),
                                  myTextWidget(
                                    text: "Workout guides",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontColor:
                                        AppColors.primary.withOpacity(0.56),
                                    fontFamily: "Arial",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  buildCrossTrueContainer(
                                    icon: Icons.check,
                                    iconColor: AppColors.black,
                                    backColor: AppColors.buttonColor,
                                  ),
                                  myTextWidget(
                                    text: "Exercise videos",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontColor:
                                        AppColors.primary.withOpacity(0.56),
                                    fontFamily: "Arial",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  buildCrossTrueContainer(
                                    icon: Icons.check,
                                    iconColor: AppColors.black,
                                    backColor: AppColors.buttonColor,
                                  ),
                                  myTextWidget(
                                    text: "Interactive schedule",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontColor:
                                        AppColors.primary.withOpacity(0.56),
                                    fontFamily: "Arial",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const SizedBox(
                            width: 160,
                            height: 150,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/img11.jpeg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: buildCrossTrueContainer(
                                  icon: Icons.favorite,
                                  backColor: AppColors.transparent,
                                ),
                              ),
                              myTextWidget(
                                text:
                                    "Based on result from 15 million \nhappy customers.",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontColor: AppColors.black,
                                fontFamily: "Arial",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: buildCrossTrueContainer(
                                  icon: Icons.self_improvement,
                                  backColor: AppColors.transparent,
                                ),
                              ),
                              myTextWidget(
                                text:
                                    "Constantly learning and improving \nbased on your feedback.",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontColor: AppColors.black,
                                fontFamily: "Arial",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarButton(
        backgroundColor: AppColors.orange,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const FeelFromPeopleStatementScreen()));
        },
      ),
    );
  }

  Container buildCrossTrueContainer({
    IconData? icon,
    Color iconColor = Colors.black,
    Color backColor = Colors.orange,
  }) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        icon,
        size: 20,
        color: iconColor,
      ),
    );
  }
}
