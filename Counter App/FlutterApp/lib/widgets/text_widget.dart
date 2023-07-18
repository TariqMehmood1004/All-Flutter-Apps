import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;

  //constructor here
  const TextWidget(
      {super.key,
      required this.title,
      required this.textColor,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 4.0),
      alignment: Alignment.center,
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
