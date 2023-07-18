import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/your_name_screen.dart';

GestureDetector myButton(BuildContext context, void Function() onTap, {
  Color backgroundColor = Colors.grey,
  String title = "",
  Color foreColor = Colors.black

}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.78,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: foreColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: "Roboto",
          ),
        ),
      ),
    ),
  );
}
