import 'package:app/db/id_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'widgets.dart';

class IDCardButton extends StatelessWidget {
  final IDCard idCard;
  final void Function()? onPressed;

  const IDCardButton({
    Key? key,
    required this.idCard,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThreeWidgetButton(
      center: Lottie.asset("assets/images/id.json"),
      onPressed: onPressed,
      right: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              idCard.nickname,
            ),
          ),
        ],
      ),
    );
  }
}
