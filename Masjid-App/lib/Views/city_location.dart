import 'package:app/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class LocationCityController extends StatefulWidget {
  const LocationCityController({super.key});

  @override
  State<LocationCityController> createState() => _LocationCityControllerState();
}

class _LocationCityControllerState extends State<LocationCityController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.accentColor,
      body: Text('Location City'),
    );
  }
}
