import 'dart:async';
import 'package:flutter/material.dart';
import 'package:table_generator_app/Areas/Views/views.dart';

setTimer({int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        MaterialPageRoute(
          builder: (_) => MyViewsRoutes.dashboardController,
        );
      },
    );
