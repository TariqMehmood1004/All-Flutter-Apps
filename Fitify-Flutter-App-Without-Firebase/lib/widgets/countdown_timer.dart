// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int durationInSeconds;

  const CountdownTimer({super.key, required this.durationInSeconds});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_remainingSeconds <= 0) {
          timer.cancel();
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const GoalScreen()));
        } else {
          _remainingSeconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = _remainingSeconds / widget.durationInSeconds;
    return CircularProgressIndicator(
      value: progress,
      strokeWidth: 4,
      backgroundColor: Colors.grey,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
