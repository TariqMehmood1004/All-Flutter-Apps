import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/threewidgetbtn2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';

class GlobalSettingsScreen extends StatefulWidget {
  static const String routeName = '/globalSettings';

  const GlobalSettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GlobalSettingsScreen();
}

class _GlobalSettingsScreen extends State<GlobalSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        title: const Text('Settings',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
        leading: IconButton(
          padding: PmpTheme.appBarButtonPadding,
          splashRadius: PmpTheme.appBarButtonSplashRadius,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: [
          PmpPadding(
            ThreeWidgetBtn2(
              center: const Text('Enable autofill',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 16, 16),
                  )),
              left: const Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(
                  Icons.password_rounded,
                  color: Color.fromARGB(255, 21, 21, 21),
                ),
              ),
              right: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Color.fromARGB(255, 14, 14, 14)),
              onPressed: () {
                AutofillService().requestSetAutofillService();
              },
            ),
          )
        ],
      ),
    );
  }
}
