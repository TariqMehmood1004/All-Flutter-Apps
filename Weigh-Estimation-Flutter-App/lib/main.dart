import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/screens/statement_screens/statement_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age estimation based on Weigh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const RelateToTheFollowingStatementScreen(),
    );
  }
}
