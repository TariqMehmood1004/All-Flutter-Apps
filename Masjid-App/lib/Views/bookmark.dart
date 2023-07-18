import 'package:app/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class BookMarkController extends StatefulWidget {
  const BookMarkController({super.key});

  @override
  State<BookMarkController> createState() => _BookMarkControllerState();
}

class _BookMarkControllerState extends State<BookMarkController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.accentColor,
      body: Text('BookMark'),
    );
  }
}
