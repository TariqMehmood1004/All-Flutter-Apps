import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_widget.dart';
import '11_launch_time_screen.dart';

class RightNutritionChoicesScreen extends StatefulWidget {
  const RightNutritionChoicesScreen({Key? key}) : super(key: key);

  @override
  State<RightNutritionChoicesScreen> createState() =>
      _RightNutritionChoicesScreenState();
}

class _RightNutritionChoicesScreenState
    extends State<RightNutritionChoicesScreen> {
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: myTextWidget(
                  text: "Make the right nutrition choices",
                  fontSize: 30,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.black,
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: AppColors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/img3.jpg",
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                color: AppColors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: myTextWidget(
                  text:
                      "A great workout routine without the right food choices won't do. \n\n"
                      "Our cookbook will help you find healthy alternatives to not-so-great food choices.",
                  fontColor: AppColors.black.withOpacity(0.6),
                  fontSize: 18,
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: AppColors.transparent,
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: myButton(
                  context,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaunchTimeScreen(),
                      ),
                    );
                  },
                  title: "Continue",
                  backgroundColor: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
