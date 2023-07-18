import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/bottom_navigation_bar_button.dart';
import '../widgets/my_text_widget.dart';
import '../widgets/navigation_widget.dart';
import '16_any_workout_experience_screen.dart';

class GoodHandsScreen extends StatefulWidget {
  const GoodHandsScreen({super.key});

  @override
  State<GoodHandsScreen> createState() => _GoodHandsScreenState();
}

class _GoodHandsScreenState extends State<GoodHandsScreen> {
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
                      text: "You are in good hands",
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
                        image: AssetImage("assets/images/img5.png"),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Text.rich(
                      TextSpan(
                        text: 'And you are not alone! \n\n'
                            'Last year, ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2,037,210 people',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' from all over the world chose to lose weight with Fitify.',
                          ),
                        ],
                      ),
                    ),
                    // myTextWidget(
                    //   text: "And you are not alone! \n\n"
                    //       "Last year, 2,037,210 people from all over "
                    //       "the world chose to lose weight with Fitify.",
                    //   fontColor: AppColors.black.withOpacity(0.6),
                    //   fontSize: 18,
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarButton(
        onTap: () {
          Navigation.navigateTo(context, const AnyWorkoutExperience());
        },
        backgroundColor: AppColors.orange,
      ),
    );
  }
}
