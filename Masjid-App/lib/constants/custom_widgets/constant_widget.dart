import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var statusBarColor = SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.red,
  ),
);

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

Text myTextWidget(
    {String title = '',
    Color color = Colors.black,
    double fontSize = 23.0,
    FontWeight fontWeight = FontWeight.w500,
    String fontFamily = ''}) {
  return Text(
    title.toString(),
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    ),
  );
}
