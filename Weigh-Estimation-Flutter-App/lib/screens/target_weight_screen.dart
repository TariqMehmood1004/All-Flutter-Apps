import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/widgets/custom_target_weight_radio_button.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/radio_button.dart';
import 'focus_screen.dart';

class TargetWeightScreen extends StatefulWidget {
  const TargetWeightScreen({Key? key}) : super(key: key);

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  int selectedOption = 0;
  List<String> options = ["No", "Yes"];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Alright, now your target weight.",
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                CustomTargetWeightRadioButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container plusMinusIcon({IconData? icon}) {
    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(50),
                      ), child: Icon(icon),
                    );
  }
}
