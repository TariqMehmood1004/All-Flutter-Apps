import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/threewidgetbtn2.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/security_screen.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  static const String routeName = '/setupScreen';

  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetupScreen();
}

class _SetupScreen extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        title: const Text('Account setup',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check_rounded),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, MainScreen.routeName),
      ),
      body: ListView(
        children: [
          PmpPadding(ThreeWidgetBtn2(
              center: const Text('Security'),
              left: const Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(Icons.lock_rounded),
              ),
              right: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () =>
                  Navigator.pushNamed(context, SecurityScreen.routeName))),
        ],
      ),
    );
  }
}
