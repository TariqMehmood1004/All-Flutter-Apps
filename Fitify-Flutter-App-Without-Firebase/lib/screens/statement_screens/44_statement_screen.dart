import 'package:fitifyapp/widgets/card_container.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../widgets/show_snack_bar.dart';

class RelateToTheFollowingStatementScreen extends StatefulWidget {
  const RelateToTheFollowingStatementScreen({Key? key}) : super(key: key);

  @override
  State<RelateToTheFollowingStatementScreen> createState() =>
      _RelateToTheFollowingStatementScreenState();
}

class _RelateToTheFollowingStatementScreenState
    extends State<RelateToTheFollowingStatementScreen> {
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
                    text: "I wish to feel more confident in myself.",
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
                          showSnackBar(
                              context: context,
                              msg: "This is the last page of App.");
                        },
                      ),
                      MyCardContainerWithoutImage(
                        title: "No",
                        onTap: () {
                          showSnackBar(
                              context: context,
                              msg: "This is the last page of App.");
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

// // ignore_for_file: prefer_const_constructors
// import 'package:fitifyapp/colors/colors.dart';
// import 'package:flutter/material.dart';
//
// import '../../widgets/card_container.dart';
// import '../../widgets/show_snack_bar.dart';
//
// class RelateToTheFollowingStatementScreen extends StatefulWidget {
//   const RelateToTheFollowingStatementScreen({super.key});
//
//   @override
//   State<RelateToTheFollowingStatementScreen> createState() =>
//       _RelateToTheFollowingStatementScreenState();
// }
//
// class _RelateToTheFollowingStatementScreenState
//     extends State<RelateToTheFollowingStatementScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: const Icon(Icons.arrow_back_ios_new_outlined),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 180,
//               alignment: Alignment.topLeft,
//               margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
//               color: AppColors.transparent,
//               child: Column(
//                 children: [
//                   Text(
//                     "Do you relate to the following statement?",
//                     style: TextStyle(
//                       color: AppColors.black,
//                       fontFamily: "Roboto",
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30,
//                     ),
//                   ),
//                   Positioned(
//                     left: 130,
//                     bottom: -10,
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: AppColors.light,
//                       ),
//                       child: const Icon(Icons.format_quote_outlined),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "I wish to feel more confident in myself.",
//                     style: TextStyle(
//                       color: AppColors.black.withOpacity(0.6),
//                       fontFamily: "Roboto",
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
//               child: Column(
//                 children: [
//                   MyCardContainerWithoutImage(
//                     title: "Yes",
//                     onTap: () {
//                       showSnackBar(
//                           context: context,
//                           msg: "This is the last page of App.");
//                     },
//                   ),
//                   MyCardContainerWithoutImage(
//                     title: "No",
//                     onTap: () {
//                       showSnackBar(
//                           context: context,
//                           msg: "This is the last page of App.");
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
