import 'package:flutter/material.dart';

Text myTextWidget({String? text,
  String fontFamily = "Roboto",
  Color fontColor = Colors.black,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    text!,
    style: TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    ),
  );
}