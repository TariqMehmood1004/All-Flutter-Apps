import 'package:app/common/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/confirm_string_scaffold.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'add_account_screen.dart';
import 'login_screen.dart';
import 'splash_screen.dart';

class RemoveAccountScreen extends StatefulWidget {
  static const String routeName = '${LoginScreen.routeName}/removeAccount';

  const RemoveAccountScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RemoveAccountScreen();
}

class _RemoveAccountScreen extends State<RemoveAccountScreen> {
  @override
  Widget build(BuildContext context) {
    String username = ModalRoute.of(context)!.settings.arguments as String;
    return ConfirmStringScaffold(
      title: const Text('Remove account',
          style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
              fontWeight: FontWeight.w500)),
      message: PmpPadding(RichText(
        text: TextSpan(
            style: const TextStyle(
                fontSize: 25,
                color: PmpTheme.appbarcolor,
                fontWeight: FontWeight.w500),
            text: 'Confirm the removal of account ',
            children: [
              TextSpan(
                text: '\'$username\' ',
                style: const TextStyle(color: Color.fromARGB(255, 31, 6, 90)),
              ),
              const TextSpan(
                  text: 'by typing in its username.\n\nThis action is '),
              const TextSpan(
                text: 'irreversible',
                style: TextStyle(color: Color.fromARGB(255, 20, 10, 108)),
              ),
              const TextSpan(text: '.'),
            ]),
        textAlign: TextAlign.center,
      )),
      labelText: 'Confirm username',
      confirmIcon: const Icon(
        Icons.delete_outline_rounded,
        color: Colors.white,
      ),
      onBackPressed: (context) => Navigator.pop(context),
      onConfirmPressed: (context, value) {
        if (value != username) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Row(children: [
                Icon(Icons.error_outline_rounded,
                    color: PmpTheme.darkContentColor),
                SizedBox(width: 20),
                Expanded(
                    child: Text('Usernames do not match',
                        style: TextStyle(
                            color: Color.fromARGB(255, 252, 249, 249)))),
              ]),
            ));
          return;
        }
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        data.removeAccount(username).then((value) {
          if (data.noAccounts) {
            Navigator.pushReplacementNamed(context, AddAccountScreen.routeName);
            return;
          }
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        });
      },
    );
  }
}
