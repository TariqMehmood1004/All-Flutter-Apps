import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';

class CounterWidgetController extends StatelessWidget {
  final dynamic number;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  //constructor goes here
  const CounterWidgetController(
      {super.key,
      this.number = "R",
      required this.textColor,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.transamberorange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
