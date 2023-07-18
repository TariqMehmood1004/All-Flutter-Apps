
import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';

class MyNotesContainer extends StatelessWidget {
  const MyNotesContainer({
    super.key,
    required String dateTime,
  }) : _dateTime = dateTime;

  final String _dateTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: AppColors.yellowRGBA,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Web Development Lab",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "FYP Lab",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Text(
                _dateTime,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 5,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Image(
                  image: AssetImage("assets/images/tetris.png"),
                ),
              )
          ),
        ),
      ],
    );
  }
}
