// ignore_for_file: deprecated_member_use

import 'package:app/common/assets.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/screens/confirm_restore_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pmp/widgets/threewidgetbtn2.dart';
import 'backup_and_restore_screen.dart';

class RestoreScreen extends StatefulWidget {
  const RestoreScreen({Key? key}) : super(key: key);

  static const routeName = '${BackupAndRestoreScreen.routeName}/restore';

  @override
  State<StatefulWidget> createState() => _RestoreScreen();
}

class _RestoreScreen extends State<RestoreScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text('Restore',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: ListView(children: [
        PmpPadding(ThreeWidgetBtn2(
          center: const Text(' restore'),
          left: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset(
              logoCircleSvg,
              width: 30,
              color: PmpTheme.lightContentColor,
            ),
          ),
          right: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            FilePicker.platform.pickFiles(
              dialogTitle: 'Restore  backup',
              type: FileType.custom,
              allowedExtensions: ['zip'],
            ).then(
              (pick) {
                if (pick == null) return;
                Navigator.pushNamed(
                  context,
                  ConfirmRestoreScreen.routeName,
                  arguments: pick.files[0].path,
                );
              },
            );
          },
        )),
      ]),
    );
  }
}
