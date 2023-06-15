
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tiktok/common/app_colors.dart';
import 'package:tiktok/common/widgets.dart';
import 'package:tiktok/screens/home_screen.dart';

class SplashScreenController extends StatefulWidget {
  const SplashScreenController({super.key});

  @override
  State<SplashScreenController> createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController> {
  @override
  void initState() {
    super.initState();
    systemChrome();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black2,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.black2,
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
                        backgroundImage: AssetImage('assets/images/playstore.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'tikTok',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
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
                          color: AppColors.white, fontSize: 8.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Notio Software Solutions',
                      style: TextStyle(
                          color: AppColors.white, fontSize: 8.0),
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
