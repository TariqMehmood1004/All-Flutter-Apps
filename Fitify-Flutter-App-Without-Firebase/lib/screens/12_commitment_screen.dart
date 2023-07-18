// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:fitifyapp/screens/13_together_we_can_do_it_screen.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/my_text_widget.dart';

class CommitmentScreen extends StatefulWidget {
  const CommitmentScreen({super.key});

  @override
  State<CommitmentScreen> createState() => _CommitmentScreenState();
}

class _CommitmentScreenState extends State<CommitmentScreen> {
  bool isFilledBackground = false;
  double fillBackground = 160.0;

  bool isTapping = false;
  double containerWidth = 160.0;
  double containerHeight = 160.0;
  Color containerColor = Colors.red;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startSpreading() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        containerWidth += 10.0;
        containerHeight += 10.0;
      });
    });
  }

  void _stopSpreading() {
    timer?.cancel();
    setState(() {
      containerWidth = 160;
      containerHeight = 160;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFilledBackground ? AppColors.yellowAccent : null,
      appBar: AppBar(
        backgroundColor: isFilledBackground ? AppColors.yellowAccent : null,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: myTextWidget(
                      text: "Your commitment",
                      fontSize: 30,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.black,
                    ),
                  ),
                  Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: myTextWidget(
                      text:
                          "I have decided I am ready to get fit and stay fit. \n\n"
                          "I will work consistently towards reaching my fitness goals. "
                          "I will remain patient with myself and my progress.",
                      fontColor: AppColors.black.withOpacity(0.6),
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        isTapping = true;
                      });
                      _startSpreading();
                    },
                    onTapUp: (_) {
                      setState(() {
                        isTapping = false;
                      });
                      _stopSpreading();
                    },
                    onTapCancel: () {
                      setState(() {
                        isTapping = false;
                      });
                      _stopSpreading();
                      Timer(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const TogetherWeCanDoItScreen()));
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        isFilledBackground = !isFilledBackground;
                        fillBackground++;
                      });
                    },
                    child: Container(
                      width: isFilledBackground ? fillBackground : 160,
                      height: isFilledBackground ? fillBackground : 160,
                      margin: const EdgeInsets.only(top: 100),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: isFilledBackground
                              ? AppColors.pink
                              : AppColors.orange,
                          width: isFilledBackground ? 15 : 5,
                        ),
                      ),
                      child: Container(
                        width: isFilledBackground ? fillBackground : 160,
                        height: isFilledBackground ? fillBackground : 160,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColors.white,
                            width: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: myTextWidget(
                      text: "Tap and hold the button to continue",
                      fontColor: AppColors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FillingContainer extends StatefulWidget {
  const FillingContainer({Key? key}) : super(key: key);

  @override
  _FillingContainerState createState() => _FillingContainerState();
}

class _FillingContainerState extends State<FillingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double fillBackground = 0;
  bool isFilledBackground = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  void _reverseAnimation() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isFilledBackground = !isFilledBackground;
          if (isFilledBackground) {
            _startAnimation();
          } else {
            _reverseAnimation();
          }
        });
      },
      child: Container(
        width: 160,
        height: 160,
        margin: const EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.orange,
            width: 5,
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: isFilledBackground
                  ? fillBackground * _animationController.value
                  : 160,
              height: isFilledBackground
                  ? fillBackground * _animationController.value
                  : 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 12,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
