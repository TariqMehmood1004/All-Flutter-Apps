

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/app_colors.dart';

void systemChrome() => SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
  statusBarColor: AppColors.transparent,
  ),
);