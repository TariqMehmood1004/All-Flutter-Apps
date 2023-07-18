import 'dart:async';
import 'package:flutter/material.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';
import 'package:list_view_project/views/dashboard_controller/dashboard_controller.dart';
import 'package:list_view_project/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      debugPrint("loading the app");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const DashboardScreen(title: "Dashboard Screen"),
        ),
      );
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackBackColor,
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 650,
                color: AppColors.blackBackColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Image(
                      width: 60,
                      height: 60,
                      color: Colors.amber,
                      image: AssetImage('images/app.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TextWidget(
              title: 'From', textColor: AppColors.amberorange, fontSize: 8),
          TextWidget(
              title: 'Notio Software Solutions',
              textColor: AppColors.amberorange,
              fontSize: 8),
        ],
      ),
    );
  }
}
