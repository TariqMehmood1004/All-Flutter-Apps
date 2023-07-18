
import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';

class BottomSheetBar extends StatefulWidget {
  const BottomSheetBar({super.key});

  @override
  State<BottomSheetBar> createState() => _BottomSheetBarState();
}

class _BottomSheetBarState extends State<BottomSheetBar> {

  showBottomSheetModal() {
    Future.delayed(const Duration(milliseconds: 15), () {
      showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        barrierColor: AppColors.buttonColor,
        context: context,
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          height: 900,
          color: AppColors.transparent,
          child: const Text("Bottom Sheet Modal"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return showBottomSheetModal();
  }
}
