// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';
import 'package:weigh_estimation_app/widgets/my_textfields.dart';

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    Key? key,
    this.isMoved = false,
  }) : super(key: key);
  bool? isMoved;


  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  int _selectedOption = 0;


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



  String selectedOption = 'cm';
  final cmController = TextEditingController();
  final feetController = TextEditingController();
  final inchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if (selectedOption == 'cm') ...[
          MyTextFields1(cmController: cmController,),

        ] else ...[
          MyTextFields2(feetController: feetController, inchController: inchController,),
        ],

        Container(
          width: MediaQuery.of(context).size.width * 0.36,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOption1('cm'),
              buildOption1('ft & in'),
            ],
          ),
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

  Widget buildOption2(int option, String label) {
    final bool isSelected = _selectedOption == option;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = option;
            });

            if (isSelected) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              final double animationValue =
              isSelected ? _animation.value.dx : -_animation.value.dx;

              return Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? AppColors.black : AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


//
// class CustomRadioButton2 extends StatefulWidget {
//   const CustomRadioButton2({Key? key}) : super(key: key);
//
//   @override
//   _CustomRadioButton2State createState() => _CustomRadioButton2State();
// }
//
// class _CustomRadioButtonState extends State<CustomRadioButton2>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _animation;
//   int _selectedOption = 0;
//
//   @override
//   void initState() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     _animation = Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0)).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.36,
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           buildOption(0, 'cm', const TextField()),
//           buildOption(
//             1,
//             'ft & in',
//             const Column(
//               children: [
//                 TextField(),
//                 SizedBox(height: 10),
//                 TextField(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildOption(int option, String label, Widget inputField) {
//     final bool isSelected = _selectedOption == option;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedOption = option;
//         });
//
//         if (isSelected) {
//           _animationController.reverse();
//         } else {
//           _animationController.forward();
//         }
//       },
//       child: AnimatedBuilder(
//         animation: _animationController,
//         builder: (BuildContext context, Widget? child) {
//           final double animationValue =
//           isSelected ? _animation.value.dx : -_animation.value.dx;
//
//           return Container(
//             margin: const EdgeInsets.all(4),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.light : Colors.transparent,
//               borderRadius: BorderRadius.circular(20),
//               gradient: LinearGradient(
//                 begin: Alignment(animationValue, 0),
//                 end: Alignment(1 - animationValue, 0),
//                 colors: [
//                   Colors.white.withOpacity(0.2),
//                   Colors.white.withOpacity(0.8),
//                 ],
//               ),
//             ),
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? AppColors.black : AppColors.primary,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Roboto",
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
