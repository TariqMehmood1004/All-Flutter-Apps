import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:table_generator_app/Areas/Controllers/index.dart';
import 'package:table_generator_app/Utilities/utils/colors.dart';

class GenerateTableController extends StatefulWidget {
  const GenerateTableController(
      {super.key,
      required this.tableNumber,
      required this.startingNumber,
      required this.endingNumber});

  final int tableNumber;
  final int startingNumber;
  final int endingNumber;

  @override
  State<GenerateTableController> createState() =>
      _GenerateTableControllerState();
}

class _GenerateTableControllerState extends State<GenerateTableController> {
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
                      width: 250,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Table Number: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.blueLight,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                                child: Text(
                              widget.tableNumber.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = widget.startingNumber;
                        i <= widget.endingNumber;
                        i++)
                      Container(
                        width: 250,
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(vertical: 1.0),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.tableNumber.toString()} \t\t\t\t\t * '
                              '\t\t\t\t\t $i \t\t\t\t\t = '
                              '\t\t\t\t\t\t\t ${widget.tableNumber * i} ',
                              style: TextStyle(
                                color: AppColors.paletteColor1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 100,
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
                      randomSounds();
                      setState(() {
                        backToHome(context);
                      });
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
                                      RandomQuestionsGenerator(
                                          tableNumber: widget.tableNumber,
                                          startingNumber: widget.startingNumber,
                                          endingNumber: widget.endingNumber),
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
                            'Quiz',
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

  void backToHome(BuildContext context) {
    Timer(const Duration(milliseconds: 250), () {
      Navigator.of(context).pop();
    });
  }

  void randomSounds() {
    AudioCache().play('audio/note${Random().nextInt(7) + 1}.wav');
  }
}
