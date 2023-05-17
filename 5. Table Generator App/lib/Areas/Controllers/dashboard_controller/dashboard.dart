import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../Utilities/utils/colors.dart';
import '../index.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({super.key});

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  int tableNumbervalue = 10, startingTableValue = 1, endingTableValue = 10;
  int minValue = 1;
  int maxValue = 100;

  bool isActive = false;
  Color primaryColor = AppColors.blueLight;
  Color secondaryColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mySliderWidget(title: 'Table Number'),
                    const SizedBox(
                      height: 50,
                    ),
                    mySliderWidgetForStartingTable(title: 'Starting Table'),
                    const SizedBox(
                      height: 50,
                    ),
                    mySliderWidgetForEndingTable(title: 'Ending Table'),
                  ],
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    // AudioCache().play('note1.wav');
                    AudioCache()
                        .play('audio/note${Random().nextInt(7) + 1}.wav');
                    setState(
                      () {
                        Timer(
                          const Duration(milliseconds: 250),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenerateTableController(
                                    tableNumber: tableNumbervalue.toInt(),
                                    startingNumber: startingTableValue.toInt(),
                                    endingNumber: endingTableValue.toInt()),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 200.0,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Generate Table',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding mySliderWidget({String title = 'Title goes here'}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.paletteColor1,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    tableNumbervalue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Slider(
                  value: tableNumbervalue.toDouble(),
                  min: minValue.toDouble(),
                  max: maxValue.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      tableNumbervalue = newValue.round();
                    });
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    maxValue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding mySliderWidgetForStartingTable({String title = 'Title goes here'}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.paletteColor1,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    startingTableValue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Slider(
                  value: startingTableValue.toDouble(),
                  min: minValue.toDouble(),
                  max: maxValue.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      startingTableValue = newValue.round();
                    });
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    maxValue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding mySliderWidgetForEndingTable({String title = 'Title goes here'}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.paletteColor1,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    endingTableValue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Slider(
                  value: endingTableValue.toDouble(),
                  min: minValue.toDouble(),
                  max: maxValue.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      endingTableValue = newValue.round();
                    });
                  },
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    maxValue.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
