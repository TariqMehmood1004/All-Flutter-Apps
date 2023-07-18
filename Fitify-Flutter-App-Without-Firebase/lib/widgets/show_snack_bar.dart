import 'package:flutter/material.dart';

import '../colors/colors.dart';

void showSnackBar({BuildContext? context, String msg = "message"}) {
  final snackBar = SnackBar(
    backgroundColor: AppColors.snackBarBGColor3,
    content: Text(
      'Yay! ${msg.toString()}',
      style: TextStyle(color: AppColors.white),
    ),
    action: SnackBarAction(
      label: 'Ok',
      textColor: AppColors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}
