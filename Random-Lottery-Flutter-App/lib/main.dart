import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int n = 3;
  Random rand = Random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: Column(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: const Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('images/lottery.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'the Lottery App'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Rubik Medium',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Column(
                    children: const [
                      Center(
                        child: Text(
                          'The Lottery Number is 5 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Rubik Regular',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 350,
                          height: 140,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              n == 5
                                  ? Text(
                                      "Congratulations! The $n number has been matched.",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'Rubik Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      "Better luck for the next time and your number is $n, Try again.",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Rubik Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            n = rand.nextInt(10);
            setState(() {});
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
