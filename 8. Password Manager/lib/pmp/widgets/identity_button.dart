import 'package:app/db/identity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets.dart';

class IdentityButton extends StatelessWidget {
  final Identity identity;
  final void Function()? onPressed;

  const IdentityButton({
    Key? key,
    required this.identity,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThreeWidgetButton(
      center: Lottie.asset("assets/images/identity.json"),
      onPressed: onPressed,
      right: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              identity.nickname,
            ),
          ),
        ],
      ),
    );
  }
}
