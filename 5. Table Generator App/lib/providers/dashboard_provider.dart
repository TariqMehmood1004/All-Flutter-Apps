

import 'package:flutter/cupertino.dart';

import '../Utilities/utils/colors.dart';

class DashboardProvider with ChangeNotifier {
  int tableNumbervalue = 10, startingTableValue = 1, endingTableValue = 10;
  int minValue = 1;
  int maxValue = 100;

  bool isActive = false;
  Color primaryColor = AppColors.blueLight;
  Color secondaryColor = AppColors.black;
}
