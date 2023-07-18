// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../widgets/my_text_widget.dart';

class RelateToTheFollowingStatementScreen extends StatefulWidget {
  const RelateToTheFollowingStatementScreen({Key? key}) : super(key: key);

  @override
  State<RelateToTheFollowingStatementScreen> createState() =>
      _RelateToTheFollowingStatementScreenState();
}

class _RelateToTheFollowingStatementScreenState
    extends State<RelateToTheFollowingStatementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        // actions: [
        //   Stack(
        //     children: [
        //       Container(
        //         width: 25,
        //         height: 25,
        //         margin: const EdgeInsets.only(right: 30),
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(50),
        //         ),
        //         child: const Center(
        //           child: CountdownTimer(durationInSeconds: 20),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: myTextWidget(
              text: "Testing",
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto"
            ),
          ),
        ),
      ),
    );
  }
}
