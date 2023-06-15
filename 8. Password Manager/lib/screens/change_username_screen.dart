import 'package:app/db/loaded_account.dart';
import 'package:app/pmp/widgets/confirm_string_scaffold.dart';
import 'package:flutter/material.dart';

import '../common/common.dart';
import 'credentials_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import 'splash_screen.dart';

class ChangeUsernameScreen extends StatefulWidget {
  static const String routeName =
      '${CredentialsScreen.routeName}/changeUsername';

  const ChangeUsernameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangeUsernameScreen();
}

class _ChangeUsernameScreen extends State<StatefulWidget> {
  final LoadedAccount _account = data.loadedAccount!;

  @override
  Widget build(BuildContext context) {
    return ConfirmStringScaffold(
      onBackPressed: (context) => Navigator.pop(context),
      title: const Text('Change username',
          style: TextStyle(
            color: Color.fromARGB(255, 250, 250, 250),
          )),
      labelText: 'New username',
      onConfirmPressed: (context, value) {
        if (value.length < 2) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Row(children: [
            Icon(Icons.person_rounded, color: Color.fromARGB(255, 15, 16, 16)),
            SizedBox(width: 20),
            Text('Username is shorter than 2 letters',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                )),
          ])));
          return;
        }
        if (data.hasAccount(value)) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Row(children: [
            Icon(Icons.person_rounded, color: Color.fromARGB(255, 14, 15, 15)),
            SizedBox(width: 20),
            Text('Username is already in use',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                )),
          ])));
          return;
        }
        Navigator.popUntil(
          context,
          (route) {
            if (route.settings.name != MainScreen.routeName) {
              return false;
            }
            Navigator.pushReplacementNamed(context, SplashScreen.routeName);
            data.changeAccountUsername(_account.username, value).then(
                  (_) => Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName),
                );
            return true;
          },
        );
      },
      message: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          text: 'Current username is ',
          children: [
            TextSpan(
              text: _account.username,
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
              ),
            ),
            const TextSpan(text: '.\nType in the new username.'),
          ],
        ),
      ),
    );
  }
}
