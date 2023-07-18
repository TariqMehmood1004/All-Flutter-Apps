import 'package:flutter/material.dart';
import 'package:table_generator_app/Utilities/methods/system_chrome_taskbar.dart';
import 'package:table_generator_app/Utilities/methods/timer.dart';
import 'package:table_generator_app/Utilities/utils/colors.dart';

class SplashScreenController extends StatefulWidget {
  const SplashScreenController({super.key});

  @override
  State<SplashScreenController> createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController> {
  @override
  void initState() {
    super.initState();

    systemChromeStatusBarColor(AppColors.transparent);
    timerForNavigation(context, seconds: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 730,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Table Generator App',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                // height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, //y-axis
                  crossAxisAlignment: CrossAxisAlignment.center, //x-axis
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.goldGrain,
                        strokeWidth: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'From',
                      style: TextStyle(
                          color: AppColors.paletteColor1, fontSize: 8.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Notio Software Solutions',
                      style: TextStyle(
                          color: AppColors.paletteColor1, fontSize: 8.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
