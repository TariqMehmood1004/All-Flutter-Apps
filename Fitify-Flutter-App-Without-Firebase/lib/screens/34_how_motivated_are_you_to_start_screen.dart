import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/35_thanks_for_sharing_screen.dart';
import 'package:flutter/material.dart';

class MotivatedScreen extends StatefulWidget {
  const MotivatedScreen({Key? key}) : super(key: key);

  @override
  State<MotivatedScreen> createState() => _MotivatedScreenState();
}

class _MotivatedScreenState extends State<MotivatedScreen> {
  int selectedOption = 0;

  List<String> options = [
    "I'm very motivated!",
    "I'm motivated",
    "Not so much",
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
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  color: AppColors.transparent,
                  child: Column(
                    children: [
                      Text(
                        "How motivated are you to start?",
                        style: TextStyle(
                          color: AppColors.black,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int index = 0; index < options.length; index++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ThanksForSharingScreen()));
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
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
          ),
        ));
  }
}
