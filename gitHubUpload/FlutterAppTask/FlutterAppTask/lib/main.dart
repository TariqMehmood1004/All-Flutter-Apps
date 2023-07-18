import 'package:flutter/material.dart';
import 'package:list_view_project/views/splash_screen_controller/splash_screen_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:list_view_project/views/splash_screen_controller/splash_screen_controller.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Color(0xffffbf00),
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: const SplashScreen(),
    );
  }
}

/*
//
//
// Counter widget
int selectedCounterIndex = 0;
List<int> countValues = [0, 0, 0, 0];

class Counters extends StatefulWidget {
  const Counters({super.key});

  @override
  State<Counters> createState() => _CountersState();
}

class _CountersState extends State<Counters> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCounterIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedCounterIndex == 0
                            ? Colors.white
                            : Colors.white,
                        border: selectedCounterIndex == 0
                            ? Border.all(color: Colors.blueAccent)
                            : Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CounterWidgetController(
                          textTitle: "Counter 1",
                          textColor: AppColors.amberorange,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCounterIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedCounterIndex == 1
                            ? Colors.white
                            : Colors.white,
                        border: selectedCounterIndex == 1
                            ? Border.all(color: Colors.blueAccent)
                            : Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CounterWidgetController(
                          textTitle: "Counter 2",
                          textColor: AppColors.amberorange,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCounterIndex = 2;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedCounterIndex == 2
                            ? Colors.white
                            : Colors.white,
                        border: selectedCounterIndex == 2
                            ? Border.all(color: Colors.blueAccent)
                            : Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CounterWidgetController(
                          textTitle: "Counter 3",
                          textColor: AppColors.amberorange,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CounterWidgetController(
                textTitle: "Count: ${countValues[selectedCounterIndex]}",
                textColor: AppColors.amberorange,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  countValues[selectedCounterIndex]++;
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.arrow_left_rounded),
              onPressed: () {
                setState(() {
                  countValues[selectedCounterIndex]--;
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  countValues[selectedCounterIndex] = 0;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/