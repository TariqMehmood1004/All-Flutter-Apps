import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_generator_app/providers/dashboard_provider.dart';
import '../../../Utilities/utils/colors.dart';
import '../index.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({super.key});

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
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
                Consumer<DashboardProvider>(
                  builder: (context, value, child) {
                    return InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        randomSounds();
                        setState(
                          () {
                            goToGenerateTableController(context, value);
                          },
                        );
                      },
                      child: Consumer<DashboardProvider>(
                        builder: (context, value, child) {
                          return Container(
                            width: 200.0,
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: value.primaryColor,
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
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToGenerateTableController(
      BuildContext context, DashboardProvider value) {
    Timer(
      const Duration(milliseconds: 250),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenerateTableController(
                tableNumber: value.tableNumbervalue.toInt(),
                startingNumber: value.startingTableValue.toInt(),
                endingNumber: value.endingTableValue.toInt()),
          ),
        );
      },
    );
  }

  void randomSounds() {
    AudioCache().play('audio/note${Random().nextInt(7) + 1}.wav');
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
                  child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.tableNumbervalue.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Consumer<DashboardProvider>(
                  builder: (context, value, child) {
                    return Slider(
                      value: value.tableNumbervalue.toDouble(),
                      min: value.minValue.toDouble(),
                      max: value.maxValue.toDouble(),
                      onChanged: (double newValue) {
                        setState(() {
                          value.tableNumbervalue = newValue.round();
                        });
                      },
                    );
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
                  child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.maxValue.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
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
                  child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.startingTableValue.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                  return Slider(
                    value: value.startingTableValue.toDouble(),
                    min: value.minValue.toDouble(),
                    max: value.maxValue.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        value.startingTableValue = newValue.round();
                      });
                    },
                  );
                }),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.maxValue.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
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
                  child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.endingTableValue.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Consumer<DashboardProvider>(
                    builder: (context, value, child) {
                  return Slider(
                    value: value.endingTableValue.toDouble(),
                    min: value.minValue.toDouble(),
                    max: value.maxValue.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        value.endingTableValue = newValue.round();
                      });
                    },
                  );
                }),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Consumer<DashboardProvider>(
                      builder: (context, value, child) {
                    return Text(
                      value.maxValue.toString(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
