

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/colors/colors.dart';

class ToastMessage {

  toastMessage({String? msg}) {
    Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.pink,
        textColor: AppColors.white,
        fontSize: 16.0,
        webPosition: "bottom",
    );
  }


  showCustomToast({String? message}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.blueGrey,
      ),
      child: Text(
        message!,
        style: const TextStyle(color: Colors.white),
      ),
    );

    FToast()?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  void showSnackBar(BuildContext context, {String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text('Yay! ${msg.toString()}', style: TextStyle(color: AppColors.white),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}