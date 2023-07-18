import 'package:fitifyapp/widgets/my_button.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarButton extends StatelessWidget {
  const BottomNavigationBarButton({
    super.key,
    this.backgroundColor = Colors.grey,
    required this.onTap,
  });

  final Color backgroundColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 25,
          ),
        ],
      ),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: myButton(context, onTap,
              title: "Continue", backgroundColor: backgroundColor)),
    );
  }
}
