import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:table_generator_app/Areas/Views/views.dart';

import '../../../Utilities/utils/colors.dart';

class RandomQuestionsGenerator extends StatefulWidget {
  const RandomQuestionsGenerator(
      {super.key,
      required this.tableNumber,
      required this.startingNumber,
      required this.endingNumber});
  final int tableNumber;
  final int startingNumber;
  final int endingNumber;

  @override
  State<RandomQuestionsGenerator> createState() =>
      _RandomQuestionsGeneratorState();
}

class _RandomQuestionsGeneratorState extends State<RandomQuestionsGenerator> {
  int tableN = 0;
  late int minValue;
  late int maxValue;
  late int randomValues;
  late int correctAnswer;

  List<int> options = [];

  @override
  void initState() {
    super.initState();

    generateRandomTableNumber();

    correctAnswer = widget.tableNumber * randomValues; // 10 * 12 = 120

    options = generateOptions();
  }

  generateRandomTableNumber() {
    tableN = widget.tableNumber;
    minValue = widget.startingNumber;
    maxValue = widget.endingNumber;
    randomValues = minValue + Random().nextInt(maxValue - minValue + 1);
  }

  List<int> generateOptions() {
    List<int> options = [];
    Random random = Random();

    // Add correct answer
    options.add(correctAnswer);

    // Generate incorrect options
    while (options.length < 3) {
      int option = random.nextInt(20) + 1;
      if (!options.contains(option) && option != correctAnswer) {
        options.add(option);
      }
    }

    options.shuffle();
    return options;
  }

  void verifyNumber(int chosenNum) {
    if (chosenNum == correctAnswer) {
      ShowDialogBox(context, 'Correct', 'You have chosen the correct number.',
          () {
        generateRandomTableNumber();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => super.widget,
          ),
        );
        randomSounds();
      });
    } else {
      ShowDialogBox(context, 'Incorrect', 'You have chosen the wrong number.',
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => super.widget,
          ),
        );
        randomSounds();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Generated Question from the table',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 40.0),
                      decoration: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.tableNumber.toString()} \t\t\t *  \t\t\t\t ${randomValues.toString()} \t\t\t = \t\t\t _____ ',
                            style: TextStyle(
                              color: AppColors.paletteColor1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: options.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              overlayColor: MaterialStateProperty.all(
                                  AppColors.transparent),
                              onTap: () {
                                randomSounds();
                                verifyNumber(e);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.blueLight,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                    child: Text(
                                  e.toString(),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.only(left: 30.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      debugPrint('generated Quiz');
                      randomSounds();
                      setState(
                        () {
                          Timer(
                            const Duration(milliseconds: 250),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyViewsRoutes.dashboardController,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: AppColors.blueLight,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 14,
                          color: AppColors.white,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint(
                          '------------------------------Next Quiz---------------------------------');
                      randomSounds();
                      setState(
                        () {
                          randomSounds();
                          Timer(
                            const Duration(milliseconds: 250),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => super.widget,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: AppColors.blueLight,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Next Question',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.white,
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
    );
  }

  void randomSounds() {
    AudioCache().play('audio/note${Random().nextInt(7) + 1}.wav');
  }

// ignore: non_constant_identifier_names
  Future<dynamic> ShowDialogBox(BuildContext context, String showTitle,
      String description, VoidCallback onPressed) {
    return showDialog(
      barrierColor: AppColors.blackTransparent,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.chocolateColor,
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            ),
          ],
          title: Text(
            showTitle.toUpperCase(),
            style: TextStyle(
              color: AppColors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          content: Text(
            description.toString(),
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: AppColors.colorBox2,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }
}
