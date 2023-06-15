import 'dart:async';

import 'package:app/db/custom_field.dart';
import 'package:app/pmp/widgets/custom_field_button.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import '../common/common.dart';
import '../db/loaded_account.dart';
import '../db/password.dart';
import '../db/tfa.dart';
import '../pmp/theme.dart';
import '../pmp/widgets/entry_screen_appbar.dart';
import '../pmp/widgets/favicon_image.dart';
import '../pmp/widgets/padding.dart';
import '../pmp/widgets/record_button.dart';
import 'common.dart';
import 'edit_password_screen.dart';
import 'main_screen.dart';
import 'passwords_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/password';

  @override
  State<StatefulWidget> createState() => _PasswordScreen();
}

class _PasswordScreen extends State<PasswordScreen> {
  final Completer<void> _onClosed = Completer<void>();
  final LoadedAccount _account = data.loadedAccount!;
  Password? password;
  Future<void>? generateTFA;
  String _tfaCode = '';
  double _tfaProgress = 0;

  Future<void> _generateTFA(TFA tfa) async {
    double tfaProgressLast = 1.0;

    while (true) {
      if (_onClosed.isCompleted) return;
      double tfaCycles =
          (DateTime.now().millisecondsSinceEpoch / 1000) / tfa.interval;
      setState(() {
        _tfaProgress = tfaCycles - tfaCycles.floor();
      });
      if (_tfaProgress < tfaProgressLast) {
        setState(() {
          _tfaCode = OTP.generateTOTPCodeString(
            tfa.secret,
            DateTime.now().millisecondsSinceEpoch,
            length: tfa.length,
            interval: tfa.interval,
            algorithm: tfa.algorithm,
            isGoogle: tfa.isGoogle,
          );
        });
      }
      tfaProgressLast = _tfaProgress;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    _onClosed.complete();
  }

  void _onRemovePressed(Password password) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: PmpTheme.dialogShape,
            title: const Text('Remove password'),
            content:
                const Text('Passwords can only be restored from a backup.'),
            actions: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 232, 238, 241)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Color.fromARGB(255, 242, 243, 244)),
                ),
                onPressed: () {
                  _account.removePassword(password.key);
                  Navigator.popUntil(
                      context, (r) => r.settings.name == MainScreen.routeName);
                  _account.savePasswords().whenComplete(() =>
                      Navigator.pushNamed(context, PasswordsScreen.routeName));
                },
              )
            ],
          );
        });
  }

  void _onEditPressed(Password password) {
    Navigator.pushNamed(
      context,
      EditPasswordScreen.routeName,
      arguments: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (password == null) {
      password = ModalRoute.of(context)!.settings.arguments as Password;
      if (password!.tfa != null) generateTFA = _generateTFA(password!.tfa!);
    }

    return Scaffold(
      appBar: EntryScreenAppBar(
        title: const Center(
            child: Text('Password',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                ))),
        onRemovePressed: () => _onRemovePressed(password!),
        onEditPressed: () => _onEditPressed(password!),
      ),
      body: ListView(
        children: [
          if (password!.nickname != '')
            PmpPadding(RecordButton(
              title: 'Nickname',
              value: password!.nickname,
            )),
          if (password!.username != '')
            PmpPadding(RecordButton(
              title: 'Username',
              value: password!.username,
            )),
          if (password!.email != '')
            PmpPadding(RecordButton(title: 'Email', value: password!.email)),
          if (password!.password != '')
            PmpPadding(RecordButton(
              title: 'Password',
              value: password!.password,
              obscureValue: true,
              isPassword: true,
            )),
          if (password!.tfa != null)
            Row(
              children: [
                SizedBox(
                  width: PmpTheme.Padding.left * 0.1,
                ),
                Flexible(
                  child: PmpPadding(RecordButton(
                    title: '2FA code',
                    value: _tfaCode,
                  )),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: _tfaProgress,
                    color: PmpTheme.lightContentSecondaryColor,
                  ),
                ),
              ],
            ),
          if (password!.website != '')
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: PmpTheme.Padding.left,
                      bottom: PmpTheme.Padding.bottom,
                      top: PmpTheme.Padding.top,
                    ),
                    child: RecordButton(
                      title: 'Website',
                      value: password!.website,
                      left: FavIconImage(address: password!.website, width: 40),
                    ),
                  ),
                ),
                SizedBox(
                  child: PmpPadding(
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        String url = password!.website;
                        if (!url.contains(RegExp('http:\\/\\/|https:\\/\\/'))) {
                          url = 'http://$url';
                        }
                        try {
                          openUrl(url);
                        } catch (_) {}
                      },
                      child: const Icon(Icons.open_in_browser_rounded),
                    ),
                  ),
                )
              ],
            ),
          for (CustomField customField in password!.customFields)
            PmpPadding(CustomFieldButton(customField: customField)),
          if (password!.additionalInfo != '')
            PmpPadding(RecordButton(
                title: 'Additional info', value: password!.additionalInfo)),
        ],
      ),
    );
  }
}
