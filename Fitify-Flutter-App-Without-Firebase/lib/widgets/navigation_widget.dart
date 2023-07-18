// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Navigation {
  static void navigateTo(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => child));
  }
}
