import 'package:fitifyapp/widgets/card_container.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:fitifyapp/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '43_meal_planning_statement_screen.dart';

class GetBoredEasilyStatementScreen extends StatefulWidget {
  const GetBoredEasilyStatementScreen({Key? key}) : super(key: key);

  @override
  State<GetBoredEasilyStatementScreen> createState() =>
      _GetBoredEasilyStatementScreenState();
}

class _GetBoredEasilyStatementScreenState
    extends State<GetBoredEasilyStatementScreen> {
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
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, bottom: 0, right: 25),
                  child: myTextWidget(
                    text: "Do you relate to the following statement",
                    fontSize: 30,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontColor: AppColors.black,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.format_quote_sharp,
                    size: 20,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 25, bottom: 10, right: 30),
                  padding: const EdgeInsets.only(
                      left: 20, right: 25, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: myTextWidget(
                    text: "I often waste time and get bored easily.",
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.blueBlack,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      MyCardContainerWithoutImage(
                        title: "Yes",
                        onTap: () {
                          Navigation.navigateTo(
                              context, const MealPlanningStatementScreen());
                        },
                      ),
                      MyCardContainerWithoutImage(
                        title: "No",
                        onTap: () {
                          Navigation.navigateTo(
                              context, const MealPlanningStatementScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// import 'package:fitifyapp/colors/colors.dart';
// import 'package:flutter/material.dart';
//
// import '43_meal_planning_statement_screen.dart';
//
// class GetBoredEasilyStatementScreen extends StatefulWidget {
//   const GetBoredEasilyStatementScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GetBoredEasilyStatementScreen> createState() =>
//       _GetBoredEasilyStatementScreenState();
// }
//
// class _GetBoredEasilyStatementScreenState
//     extends State<GetBoredEasilyStatementScreen> {
//   int selectedOption = 0;
//
//   List<String> options = [
//     "Yes",
//     "No",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: const Icon(Icons.arrow_back_ios_new_outlined),
//           ),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {},
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 180,
//                   alignment: Alignment.topLeft,
//                   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                   color: AppColors.transparent,
//                   child: Column(
//                     children: [
//                       Container(
//                         child: Text(
//                           "Do you relate to the following statement?",
//                           style: TextStyle(
//                             color: AppColors.black,
//                             fontFamily: "OpenSans",
//                             fontWeight: FontWeight.w900,
//                             fontSize: 30,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 130,
//                         bottom: -10,
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: AppColors.light,
//                           ),
//                           child: const Icon(Icons.format_quote_outlined),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "I often waste time and get bored easily.",
//                         style: TextStyle(
//                           color: AppColors.black,
//                           fontFamily: "OpenSans",
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       margin: const EdgeInsets.only(right: 15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           for (int index = 0; index < options.length; index++)
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedOption = index;
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const MealPlanningStatementScreen()));
//                                 });
//                               },
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 30),
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 20),
//                                 decoration: BoxDecoration(
//                                   color: selectedOption == index
//                                       ? AppColors.lightWhite
//                                       : AppColors.light,
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       options[index],
//                                       style: TextStyle(
//                                         color: AppColors.black,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     if (selectedOption == index)
//                                       Container(
//                                         width: 17,
//                                         height: 17,
//                                         padding: const EdgeInsets.all(5.0),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.offGreen,
//                                           borderRadius:
//                                               BorderRadius.circular(50),
//                                         ),
//                                         child: Container(
//                                           width: 14,
//                                           height: 14,
//                                           decoration: BoxDecoration(
//                                               color: AppColors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(50)),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
