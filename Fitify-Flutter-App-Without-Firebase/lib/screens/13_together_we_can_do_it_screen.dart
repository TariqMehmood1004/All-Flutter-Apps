import 'package:fitifyapp/screens/14_ready_to_commit.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/my_text_widget.dart';
import '../widgets/navigation_widget.dart';

class TogetherWeCanDoItScreen extends StatefulWidget {
  const TogetherWeCanDoItScreen({super.key});

  @override
  State<TogetherWeCanDoItScreen> createState() =>
      _TogetherWeCanDoItScreenState();
}

class _TogetherWeCanDoItScreenState extends State<TogetherWeCanDoItScreen> {
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
                      text: "Together we can do it!",
                      fontSize: 30,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.black,
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
                        image: AssetImage("assets/images/img4.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: myTextWidget(
                      text: "Losing 8 lbs is a very realistic goal. \n"
                          "Fitify will help you build healthy habits so you can reach your fitness goals.",
                      fontColor: AppColors.black.withOpacity(0.6),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarButton(
        onTap: () {
          Navigation.navigateTo(context, const ReadyToCommitScreen());
        },
        backgroundColor: AppColors.orange,
      ),
    );
  }
}
