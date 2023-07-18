
import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/colors/colors.dart';

class MyTextFields extends StatelessWidget {
  const MyTextFields({
    super.key,
    required this.nameController,
    required this.hintText,
    this.textInputType = TextInputType.text,
  });

  final String hintText;
  final TextEditingController nameController;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: 30, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: AppColors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),
            keyboardType: textInputType,
          ),
        ],
      ),
    );
  }
}



class MyTextFields1 extends StatelessWidget {
  const MyTextFields1({
    super.key,
    required this.cmController,
  });

  final TextEditingController cmController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: cmController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 12,
                        child: Text("cm",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyTextFields2 extends StatelessWidget {
  const MyTextFields2({
    super.key,
    required this.feetController,
    required this.inchController,
  });

  final TextEditingController feetController;
  final TextEditingController inchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: feetController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 12,
                        child: Text("ft",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: inchController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 12,
                        child: Text("in",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}




