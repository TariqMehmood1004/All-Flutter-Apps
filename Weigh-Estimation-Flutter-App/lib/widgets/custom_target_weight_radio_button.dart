// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/screens/statement_screens/statement_screen.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';
import 'package:weigh_estimation_app/widgets/my_textfields.dart';

import '../screens/weight_screen.dart';

class CustomTargetWeightRadioButton extends StatefulWidget {
  CustomTargetWeightRadioButton({
    Key? key,
    this.isMoved = false,
  }) : super(key: key);
  bool? isMoved;


  @override
  _CustomTargetWeightRadioButtonState createState() => _CustomTargetWeightRadioButtonState();
}

class _CustomTargetWeightRadioButtonState extends State<CustomTargetWeightRadioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;


  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  String selectedOption = 'kg';
  final cmController = TextEditingController();
  final feetController = TextEditingController();
  final inchController = TextEditingController();

  int number = 50;
  _increment() {
    setState(() {
      number++;
    });
  }

  _decrement() {
    setState(() {
      if(number>=0)
        {
          number--;
        } else {
        number = 0;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedOption == 'kg') ...[
          Center(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _decrement,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.circular(50),
                          ),child: Text(
                          "-",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),child: Text(
                        number.toString(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontSize: 60,
                        ),
                      ),
                      ),
                      GestureDetector(
                        onTap: _increment,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.circular(50),
                          ),child: Text(
                          "+",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

        ] else ...[
          Center(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _decrement,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.circular(50),
                          ),child: Text(
                          "-",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),child: Text(
                        number.toString(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontSize: 60,
                        ),
                      ),
                      ),
                      GestureDetector(
                        onTap: _increment,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.circular(50),
                          ),child: Text(
                          "+",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.36,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildOption1('kg'),
                  buildOption1('lbs'),
                ],
              ),
            ),
            const SizedBox(height: 120,),
            myButton(context, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      const RelateToTheFollowingStatementScreen(),
                  ),
              );
              },
                title: "Continue", backgroundColor: AppColors.yellowRGBA),
          ],
        ),
      ],
    );
  }


  Widget buildOption1(String option) {
    final bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
          number = 50;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.light : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? AppColors.black : AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }

}