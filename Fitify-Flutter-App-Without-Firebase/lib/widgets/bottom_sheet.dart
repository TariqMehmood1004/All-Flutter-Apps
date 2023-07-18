import 'package:flutter/material.dart';

import '../colors/colors.dart';
import 'card_container.dart';
import 'my_text_widget.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            myTextWidget(
              text: "Are you typically on your feet or"
                  " sitting most of the day?",
              fontFamily: "Arial",
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontColor: AppColors.black,
            ),
            const SizedBox(height: 25),
            MyCustomCardContainer(
              title: "Active",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 6),
            MyCustomCardContainer(
              title: "Seated",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
