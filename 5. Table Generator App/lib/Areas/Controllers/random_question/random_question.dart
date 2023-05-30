import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:table_generator_app/Areas/Controllers/index.dart';
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

  int countDown = 5;

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
      int option = random.nextInt(100) + 1;
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
        Navigator.of(context).pop();
        moveToNextQuestion();
      });
    } else {
      ShowDialogBox(context, 'Incorrect',
          ' You have chosen the wrong number. \n Your correct answer will be ${correctAnswer.toString()}',
          () {
        Navigator.of(context).pop();
        moveToNextQuestion();
      });
    }
  }

  moveToNextQuestion() {
    setState(() {
      if (countDown > 1) {
        generateRandomTableNumber();
        correctAnswer = widget.tableNumber * randomValues; // 10 * 12 = 120
        options = generateOptions();
        countDown--;
        randomSounds();
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DashboardController(),),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.blueLight,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardController(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
              ),
            ),
            title: Text(
              '${countDown.toString()} Questions remaining',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: options.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColors.blueLight),
                                overlayColor: MaterialStatePropertyAll(
                                    AppColors.backgroundDark),
                              ),
                              onPressed: () {
                                randomSounds();
                                verifyNumber(e);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.blueLight,
            onPressed: () {
              setState(() {
                moveToNextQuestion();
              });
            },
            child: const Icon(
              Icons.refresh_outlined,
            ),
          )),
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
