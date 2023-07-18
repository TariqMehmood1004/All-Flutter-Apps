import 'package:fitifyapp/widgets/card_container.dart';
import 'package:fitifyapp/widgets/my_text_widget.dart';
import 'package:fitifyapp/widgets/navigation_widget.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '42_get_bored_easily_statement_screen.dart';

class FeelFromPeopleStatementScreen extends StatefulWidget {
  const FeelFromPeopleStatementScreen({Key? key}) : super(key: key);

  @override
  State<FeelFromPeopleStatementScreen> createState() =>
      _FeelFromPeopleStatementScreenState();
}

class _FeelFromPeopleStatementScreenState
    extends State<FeelFromPeopleStatementScreen> {
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
                    text: "I feel enough support from people close to me.",
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
                              context, const GetBoredEasilyStatementScreen());
                        },
                      ),
                      MyCardContainerWithoutImage(
                        title: "No",
                        onTap: () {
                          Navigation.navigateTo(
                              context, const GetBoredEasilyStatementScreen());
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
