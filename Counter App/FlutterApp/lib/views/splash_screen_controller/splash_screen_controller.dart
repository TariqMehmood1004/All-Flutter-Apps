import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';
import 'package:list_view_project/views/dashboard_controller/dashboard_controller.dart';
import 'package:list_view_project/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*
    # Timer() method get duration, and navigator.
    Duration - After how many seconds the navigated page route opens.
    MaterialPageRoute() method get contex to returns screen route.
  */
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        //MaterialPageRoute() method get contex to returns screen route.
        MaterialPageRoute(
          builder: (context) =>
              const DashboardScreen(title: "Dashboard Screen"),
        ),
      );
    });

    // Set the status bar to transparent
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.amber,
    ));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.amberorange,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.amberorange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 730,
                child: Align(
                  alignment: Alignment.center,
                  child: Image(
                    width: 50,
                    height: 50,
                    color: Colors.black,
                    image: AssetImage('images/app.png'),
                  ),
                ),
              ),
              SizedBox(
                // height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, //y-axis
                  crossAxisAlignment: CrossAxisAlignment.center, //x-axis
                  children: [
                    const SizedBox(
                      width: 22,
                      height: 22,
                      /*
                        CircularProgressIndicator() showing us loading the app.
                      */
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ),
                    /*
                        SizedBox() widget showing us association of app.
                      */
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                        title: 'From',
                        textColor: AppColors.blackBackColor,
                        fontSize: 8),
                    TextWidget(
                        title: 'Notio Software Solutions',
                        textColor: AppColors.blackBackColor,
                        fontSize: 8),
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
