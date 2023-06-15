import 'package:app/common/common.dart';
import 'package:app/db/biometric_storage_data.dart';
import 'package:app/db/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locker/flutter_locker.dart';

import '../pmp/widgets/threewidgetbtn2.dart';
import 'settings_screen.dart';

class BiometricAuthScreen extends StatefulWidget {
  static const routeName = '${SettingsScreen.routeName}/bioAuth';

  const BiometricAuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BiometricAuthScreen();
}

class _BiometricAuthScreen extends State<BiometricAuthScreen> {
  String _password = '';

  @override
  Widget build(BuildContext context) {
    void setBioAuthEnabled(bool value) async {
      BiometricStorageData bioData;
      String username = data.loadedAccount!.username;
      if (value == true) {
        if (getHash(_password).toString() != data.loadedAccount!.passwordHash) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Row(children: [
                Icon(Icons.fingerprint_rounded,
                    color: PmpTheme.darkContentColor),
                SizedBox(width: 20),
                Expanded(
                    child: Text('Incorrect password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                        ))),
              ]),
            ));
          return;
        }
        bioData = BiometricStorageData(key: username, password: _password);
        try {
          await bioData.save();
        } catch (e) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Row(children: [
                Icon(Icons.fingerprint_rounded,
                    color: PmpTheme.darkContentColor),
                SizedBox(width: 20),
                Expanded(
                    child: Text('Couldn\'t authenticate',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                        ))),
              ]),
            ));
          return;
        }
      } else {
        await FlutterLocker.delete(username);
      }
      setState(() => data.loadedAccount!.bioAuthEnabled = value);
      data.loadedAccount!.saveSync();
    }

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
        title: const Text('Biometric authentication',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PmpPadding(ThreeWidgetBtn2(
            center: const Text('Biometric authentication'),
            left: const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Icon(Icons.fingerprint_rounded),
            ),
            right: Switch(
              activeColor: PmpTheme.appbarcolor,
              value: data.loadedAccount!.bioAuthEnabled,
              onChanged: (value) => setBioAuthEnabled(value),
            ),
            onPressed: () =>
                setBioAuthEnabled(!data.loadedAccount!.bioAuthEnabled),
          )),
          if (!data.loadedAccount!.bioAuthEnabled)
            PmpPadding(TextFormField(
              style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              initialValue: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Account password',
              ),
              onChanged: (value) => setState(() => _password = value),
            )),
        ],
      ),
    );
  }
}
