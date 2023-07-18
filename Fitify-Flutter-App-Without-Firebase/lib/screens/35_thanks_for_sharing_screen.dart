import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_widget.dart';
import '36_how_old_are_you.dart';

class ThanksForSharingScreen extends StatefulWidget {
  const ThanksForSharingScreen({super.key});

  @override
  State<ThanksForSharingScreen> createState() => _ThanksForSharingScreenState();
}

class _ThanksForSharingScreenState extends State<ThanksForSharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: myTextWidget(
                      text: "Thanks for sharing!",
                      fontSize: 27.5,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.primary,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: AppColors.transparent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const Image(
                        alignment: Alignment.center,
                        image: AssetImage("assets/images/img9.png"),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: myTextWidget(
                      text: "There's strong scientific evidence that being "
                          "physically active can help you lead a "
                          "healthier and happier life.",
                      fontColor: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      color: AppColors.transparent,
                      margin: const EdgeInsets.only(top: 100),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: myButton(context, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HowOldAreYouScreen()));
                      }, title: "Continue", backgroundColor: AppColors.orange)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}