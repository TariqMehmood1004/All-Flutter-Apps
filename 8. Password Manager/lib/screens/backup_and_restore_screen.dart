import 'package:app/pmp/theme.dart';
import 'package:flutter/material.dart';

import '../pmp/widgets/padding.dart';
import '../pmp/widgets/threewidgetbtn2.dart';
import 'backup_screen.dart';
import 'restore_screen.dart';
import 'settings_screen.dart';

class BackupAndRestoreScreen extends StatefulWidget {
  const BackupAndRestoreScreen({Key? key}) : super(key: key);

  static const routeName = '${SettingsScreen.routeName}/backupAndRestore';

  @override
  State<StatefulWidget> createState() => _BackupAndRestoreScreen();
}

class _BackupAndRestoreScreen extends State<BackupAndRestoreScreen> {
  void _onBackupPressed(String username) {
    Navigator.pushNamed(context, BackupScreen.routeName, arguments: username);
  }

  void _onRestorePressed() =>
      Navigator.pushNamed(context, RestoreScreen.routeName);

  @override
  Widget build(BuildContext context) {
    final String username =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        leading: IconButton(
          padding: PmpTheme.appBarButtonPadding,
          splashRadius: PmpTheme.appBarButtonSplashRadius,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Backup & Restore',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PmpPadding(ThreeWidgetBtn2(
            center: const Text('Backup'),
            left: const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Icon(Icons.ios_share_rounded),
            ),
            right: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () => _onBackupPressed(username),
          )),
          PmpPadding(ThreeWidgetBtn2(
            center: const Text('Restore'),
            left: const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Icon(Icons.settings_backup_restore_rounded),
            ),
            right: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: _onRestorePressed,
          )),
        ],
      ),
    );
  }
}
