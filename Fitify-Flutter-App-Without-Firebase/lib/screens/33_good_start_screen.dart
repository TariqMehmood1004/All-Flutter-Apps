import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/my_text_widget.dart';
import '../widgets/navigation_widget.dart';
import '34_how_motivated_are_you_to_start_screen.dart';

class GoodStartScreen extends StatefulWidget {
  const GoodStartScreen({super.key});

  @override
  State<GoodStartScreen> createState() => _GoodStartScreenState();
}

class _GoodStartScreenState extends State<GoodStartScreen> {
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
                      text: "Good start",
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
                        image: AssetImage("assets/images/img7.png"),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Text.rich(
                      TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'After ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '1 month ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'you should already feel a positive impact of exercising on your body and mind.',
                          ),
                          TextSpan(
                            text: '\n\n'
                                'But remember there are no shortcuts in fitness and committing to the longer period may help you reach your goals.',
                          ),
                        ],
                      ),
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
          Navigation.navigateTo(context, const MotivatedScreen());
        },
        backgroundColor: AppColors.orange,
      ),
    );
  }
}
