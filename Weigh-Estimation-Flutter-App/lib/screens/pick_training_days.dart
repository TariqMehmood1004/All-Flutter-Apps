import 'package:flutter/material.dart';
import 'package:weigh_estimation_app/widgets/my_button.dart';
import 'package:weigh_estimation_app/widgets/my_text_widget.dart';
import '../colors/colors.dart';
import 'anything_you_want_to_exclude.dart';
import 'diet_preference_screen.dart';

class PickTrainingDaysScreen extends StatefulWidget {
  const PickTrainingDaysScreen({Key? key}) : super(key: key);

  @override
  State<PickTrainingDaysScreen> createState() => _PickTrainingDaysScreenState();
}

class _PickTrainingDaysScreenState extends State<PickTrainingDaysScreen> {
  List<bool> isSelected = List.generate(7, (index) => true);

  bool switchButtonSelected = false;

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
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: myTextWidget(
                  text: "Pick training days!",
                  fontSize: 27.5,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.primary,
                ),
              ),
              Container(
                color: AppColors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                margin: const EdgeInsets.only(bottom: 30),
                child: myTextWidget(
                  text: "Great! Based on your data, we recommend 4 workouts per week",
                  fontColor: AppColors.black.withOpacity(0.6),
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: AppColors.transparent,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                margin: const EdgeInsets.only(bottom: 30),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    7, (index) => buildChoiceChip(index),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [

                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myTextWidget(
                                text: "Reminders",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            myTextWidget(
                              text: "Build a habit and never miss your workout day!",
                              fontWeight: FontWeight.w100,
                              fontColor: AppColors.black.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ],
                        ),
                    ),

                  Switch(
                  value: switchButtonSelected,
                  activeColor: AppColors.blueAccent,
                  onChanged: (bool value) {
                    setState(() {
                      switchButtonSelected = value;
                    });
                  },
                ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                color: AppColors.transparent,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: myButton(
                  context,
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)
                    => const AnythingExcludeScreen()));
                  },
                  title: "Continue",
                  backgroundColor: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ChoiceChip buildChoiceChip(int index) {
    return ChoiceChip(
      selected: isSelected[index],
      avatar: CircleAvatar(
        backgroundColor: AppColors.transparent,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(16.0),
      ),
      label: Text(getDayOfWeek(index)),
      selectedColor: AppColors.black.withOpacity(0.1),
      onSelected: (isNewSelected) {
        setState(() {
          isSelected[index] = isNewSelected;
        });
      },
    );
  }

  String getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return '';
    }
  }
}
