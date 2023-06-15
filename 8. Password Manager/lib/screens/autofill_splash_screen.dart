import 'package:app/common/assets.dart';
import 'package:app/common/common.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/no_accounts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutofillSplashScreen extends StatefulWidget {
  static const routeName = '/';

  const AutofillSplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutofillSplashScreen();
}

class _AutofillSplashScreen extends State<AutofillSplashScreen> {
  static bool initialized = false;

  @override
  void initState() {
    if (initialized) return;
    initialized = true;
    super.initState();
    loadData().then((value) async {
      data = value;
      if (value.noAccounts) {
        Navigator.pushReplacementNamed(context, NoAccountsScreen.routeName)
            .then((value) => SystemNavigator.pop());
        return;
      }
      Navigator.pushReplacementNamed(context, LoginScreen.routeName)
          .then((value) async {
        SystemNavigator.pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: logo60Purple,
      ),
    );
  }
}
