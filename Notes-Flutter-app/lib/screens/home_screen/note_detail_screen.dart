// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/colors/colors.dart';

import '../../widgets/constants.dart';

class NoteDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;

  const NoteDetailsScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Constants.showSnackBar(context, msg: "copied to clipboard.");
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      // backgroundColor: AppColors.light,
      appBar: AppBar(
        // backgroundColor: AppColors.light,
        title: Text('Note Detail', style: TextStyle(color: AppColors.black, fontFamily: "Segoe UI", fontSize: 25, fontWeight: FontWeight.bold),),
        centerTitle: true,
        // backgroundColor: AppColors.yellowRGBA,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Segoe UI",
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dateTime,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: "Segoe UI"
                ),
              ),
              const SizedBox(height: 16),
              //_copyToClipboard
              GestureDetector(
                onLongPress: () => _copyToClipboard(context, description),
                child: Text(
                  description,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Segoe UI"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
