// ignore_for_file: deprecated_member_use

import 'package:app/pmp/theme.dart';
import 'package:app/screens/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  static const routeName = '/log';

  @override
  Widget build(BuildContext context) {
    final String log =
        ModalRoute.of(context)!.settings.arguments as String? ?? '';
    return Scaffold(
        appBar: AppBar(
            backgroundColor: PmpTheme.appbarcolor,
            title: const Text('Log',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                )),
            centerTitle: true,
            leading: IconButton(
              padding: PmpTheme.appBarButtonPadding,
              splashRadius: PmpTheme.appBarButtonSplashRadius,
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                padding: PmpTheme.appBarButtonPadding,
                splashRadius: PmpTheme.appBarButtonSplashRadius,
                icon: const Icon(Icons.copy_rounded),
                onPressed: () => Clipboard.setData(ClipboardData(text: log)),
              ),
              IconButton(
                padding: PmpTheme.appBarButtonPadding,
                splashRadius: PmpTheme.appBarButtonSplashRadius,
                icon: SvgPicture.asset(
                  'assets/images/github_icon.svg',
                  color: PmpTheme.lightContentColor,
                ),
                onPressed: () =>
                    openUrl('https://github.com/GlitterWare//issues'),
              )
            ]),
        body: SelectableText(log));
  }
}
