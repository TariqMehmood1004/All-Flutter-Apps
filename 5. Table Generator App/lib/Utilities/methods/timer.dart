import 'dart:async';
import 'package:flutter/material.dart';
import '../../Areas/Views/views.dart';

timerForNavigation(BuildContext context, {int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyViewsRoutes.dashboardController,
          ),
        );
      },
    );


timerForGenerateTableControllerNavigation(BuildContext context, {int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyViewsRoutes.dashboardController,
          ),
        );
      },
    );
