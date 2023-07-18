import 'package:fitifyapp/screens/19_sleep_every_night_screen.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/navigation_widget.dart';

class HearAboutFitifyScreen extends StatefulWidget {
  const HearAboutFitifyScreen({Key? key}) : super(key: key);

  @override
  State<HearAboutFitifyScreen> createState() => _HearAboutFitifyScreenState();
}

class _HearAboutFitifyScreenState extends State<HearAboutFitifyScreen> {
  bool isChecked = false;
  List<String> options = [
    "Google Play",
    "TV",
    "Radio or podcast",
    "Friends or family",
    "Facebook",
    "Instagram",
    "Google search",
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: myTextWidget(
                  text: "How did you hear about Fitify?",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.black,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 30),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: selectedOption == index
                                        ? AppColors.lightWhite
                                        : AppColors.light,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
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
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: BottomNavigationBarButton(
          onTap: () {
            Navigation.navigateTo(context, const SleepEveryNightScreen());
          },
          backgroundColor: AppColors.orange,
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
