import 'package:fitifyapp/colors/colors.dart';
import 'package:fitifyapp/screens/12_commitment_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/launch_time_loader_counter.dart';

class LaunchTimeScreen extends StatefulWidget {
  const LaunchTimeScreen({super.key});

  @override
  State<LaunchTimeScreen> createState() => _LaunchTimeScreenState();
}

class _LaunchTimeScreenState extends State<LaunchTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LaunchLoaderCounter(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CommitmentScreen()));
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
