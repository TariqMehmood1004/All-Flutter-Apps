// ignore_for_file: deprecated_member_use

import 'package:app/common/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/assets.dart';

import '../pmp/widgets/padding.dart';
import '../pmp/widgets/threewidgetbtn2.dart';
import 'backup_and_restore_screen.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({Key? key}) : super(key: key);

  static const routeName = '${BackupAndRestoreScreen.routeName}/backup';

  @override
  State<StatefulWidget> createState() => _BackupScreen();
}

class _BackupScreen extends State<BackupScreen> {
  void _onBackup(String username) {
    FilePicker.platform.getDirectoryPath(dialogTitle: 'Backup ').then((buDir) {
      if (buDir == null) return;
      data.backupAccount(username, buDir);
    });
  }

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
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Backup',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: ListView(children: [
        PmpPadding(ThreeWidgetBtn2(
          center: const Text(' backup',
              style: TextStyle(
                color: Color.fromARGB(255, 20, 20, 20),
              )),
          left: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset(
              logoCircleSvg,
              width: 30,
              color: PmpTheme.lightContentColor,
            ),
          ),
          right: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () => _onBackup(username),
        )),
      ]),
    );
  }
}
