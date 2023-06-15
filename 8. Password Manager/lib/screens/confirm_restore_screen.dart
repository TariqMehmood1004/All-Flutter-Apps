import 'package:app/common/common.dart';
import 'package:app/db/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/confirm_string_scaffold.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/restore_screen.dart';
import 'package:flutter/material.dart';

import 'log_screen.dart';

class ConfirmRestoreScreen extends StatefulWidget {
  static const String routeName = '${RestoreScreen.routeName}/confirm';

  const ConfirmRestoreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmRestoreScreen();
}

class _ConfirmRestoreScreen extends State<ConfirmRestoreScreen> {
  @override
  Widget build(BuildContext context) {
    String path = ModalRoute.of(context)!.settings.arguments as String;
    return ConfirmStringScaffold(
        title: const Text(' restore'),
        message: PmpPadding(RichText(
          text: const TextSpan(
            text: 'If the account you\'re restoring already exists, then ',
            children: [
              TextSpan(
                text: 'its current data will be lost ',
                style: TextStyle(color: PmpTheme.lightContentSecondaryColor),
              ),
              TextSpan(
                  text:
                      'and replaced with the backup.\n\nEnter account password to restore.'),
            ],
          ),
          textAlign: TextAlign.center,
        )),
        labelText: 'Enter password',
        obscureText: true,
        confirmIcon: const Icon(Icons.settings_backup_restore_rounded),
        onBackPressed: (context) => Navigator.pop(context),
        onConfirmPressed: (context, value) {
          data.restoreAccount(path, encrypter: getEncrypter(value)).then(
            (value) {
              Navigator.popUntil(context,
                  (route) => route.settings.name == MainScreen.routeName);
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            onError: (e, s) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: const Row(children: [
                      Icon(Icons.settings_backup_restore_rounded,
                          color: PmpTheme.darkContentColor),
                      SizedBox(width: 20),
                      Text('Could not restore account'),
                    ]),
                    action: SnackBarAction(
                      label: 'Details',
                      onPressed: () => Navigator.pushNamed(
                          context, LogScreen.routeName,
                          arguments: '$e\n$s'),
                    ),
                  ),
                );
            },
          );
        });
  }
}
