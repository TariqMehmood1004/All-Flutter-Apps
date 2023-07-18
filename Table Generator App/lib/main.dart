import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_generator_app/providers/dashboard_provider.dart';

import 'Areas/Views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider() used for single provider
    // while MultiProvider() used for multi providers

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyViewsRoutes.splashScreenController,
      ),
    );
  }
}
