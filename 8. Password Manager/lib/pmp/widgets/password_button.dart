import 'package:app/db/password.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets.dart';

class PasswordButton extends StatelessWidget {
  final Password password;
  final void Function()? onPressed;

  const PasswordButton({
    Key? key,
    required this.password,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThreeWidgetButton(
      center: Padding(
        padding: const EdgeInsets.only(),
        child: password.website == ''
            ? Lottie.asset("assets/images/pass.json")
            : FavIconImage(address: password.website),
      ),
      onPressed: onPressed,
      right: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(password.nickname,
                style: const TextStyle(color: Color.fromARGB(255, 20, 19, 19))),
          ),
        ],
      ),
    );
  }
}
