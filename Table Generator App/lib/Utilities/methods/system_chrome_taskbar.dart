import 'package:flutter/services.dart';

// ignore: avoid_types_as_parameter_names
systemChromeStatusBarColor(Color color) => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );

