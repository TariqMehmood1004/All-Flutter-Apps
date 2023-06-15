import 'dart:io';

import 'package:app/common/assets.dart';
import 'package:app/db/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/three_widget_button.dart';
import 'package:app/screens/security_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../common/common.dart';
import 'backup_and_restore_screen.dart';
import 'credentials_screen.dart';
import 'main_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/settings';

  @override
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
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
        title: const Text('Settings',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        children: [
          PmpPadding(ThreeWidgetButton(
            right: const Text('Backup & Restore'),
            center: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Lottie.asset("assets/images/backup.json"),
            ),
            onPressed: () => Navigator.pushNamed(
                context, BackupAndRestoreScreen.routeName,
                arguments: data.loadedAccount!.username),
          )),
          if (Platform.isAndroid || Platform.isIOS)
            PmpPadding(ThreeWidgetButton(
                right: const Text('Security'),
                center: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset("assets/images/seq.json"),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, SecurityScreen.routeName))),
          PmpPadding(ThreeWidgetButton(
              right: const Text('Credentials'),
              center: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset("assets/images/cred.json"),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, CredentialsScreen.routeName))),
          PmpPadding(ThreeWidgetButton(
            right: const Text('About'),
            center: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset("assets/images/about.json"),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 24),
                            Center(child: logo60Purple),
                            const SizedBox(height: 3),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: ' ',
                                style: TextStyle(fontFamily: 'FiraCode'),
                                children: [
                                  TextSpan(
                                    text: 'v$Version',
                                    style: TextStyle(
                                      color:
                                          PmpTheme.lightContentSecondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 13),
                            const Text(
                              'Made by KingitLimited',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PmpTheme.appbarcolor,
                                fontSize: 16,
                                fontFamily: 'FiraCode',
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ));
            },
          )),
        ],
      ),
    );
  }
}
