import 'dart:io';

import 'package:app/common/common.dart';
import 'package:app/db/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/assets.dart';
import 'login_screen.dart';
import 'log_screen.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  static const routeName = '/addAccount';

  @override
  State<StatefulWidget> createState() => _AddAccountScreen();
}

class _AddAccountScreen extends State<StatefulWidget> {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  void _addAccount() {
    if (_username.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.person_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Username is empty',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.w500)),
      ])));
      return;
    }
    if (_username.length < 2) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.person_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Username is shorter than 2 letters',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.w500)),
      ])));
      return;
    }
    if (data.hasAccount(_username)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.person_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Username is already in use',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.w500)),
      ])));
      return;
    }
    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.lock_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Password is empty',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.w500)),
      ])));
      return;
    }
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.lock_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Passwords do not match',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.w500)),
      ])));
      return;
    }
    try {
      data.createAccount(
        _username,
        _password,
      );
    } catch (e, s) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: const Row(children: [
            Icon(Icons.error_outline_rounded, color: PmpTheme.darkContentColor),
            SizedBox(width: 20),
            Expanded(
                child: Text('Couldn\'t add account',
                    style: TextStyle(
                        color: Color.fromARGB(255, 251, 251, 251),
                        fontWeight: FontWeight.w500))),
          ]),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Details',
            onPressed: () => Navigator.pushNamed(context, LogScreen.routeName,
                arguments: '$e\n$s'),
          ),
        ));
      return;
    }
    data.info.value.lastUsername = _username;
    data.loadAccount(_username, getEncrypter(_password));
    data.info.save().then((value) {
      if (!Platform.isAndroid && !Platform.isIOS) {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
        return;
      }
      Navigator.pushReplacementNamed(context, SetupScreen.routeName);
    });
  }

  Future<bool> _onWillPop() {
    if (data.noAccounts) return Future.value(true);
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PmpTheme.appbarcolor,
          automaticallyImplyLeading: false,
          leading: data.noAccounts
              ? null
              : IconButton(
                  padding: PmpTheme.appBarButtonPadding,
                  splashRadius: PmpTheme.appBarButtonSplashRadius,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName),
                ),
          title: const Text(
            'Add account',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                logo60Purple,
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Password Manager Pro',
                  style: TextStyle(
                      color: Color.fromARGB(255, 185, 88, 39),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (a) =>
                                        setState(() => _username = a),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          right: 15,
                                          bottom: 0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 211, 114, 61),
                                          width: 1.0,
                                        ),
                                      ),
                                      hintText: 'Username',
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 134, 123, 123)),
                                    ),
                                    autofocus: true,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 16, 13, 13)),
                                    inputFormatters: [
                                      FilteringTextInputFormatter(
                                          RegExp(
                                              '^[a-zA-Z0-9](?:[a-zA-Z0-9 ._-]*[a-zA-Z0-9])?\$'),
                                          replacementString: _username,
                                          allow: true)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (a) =>
                                        setState(() => _password = a),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          right: 15,
                                          bottom: 0),
                                      hintText: 'Password',
                                      focusColor: Colors.black,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 134, 123, 123)),
                                    ),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 16, 13, 13)),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(32),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          right: 15,
                                          bottom: 0),
                                      hintText: 'Confirm password',
                                      focusColor: Colors.black,
                                      labelText: 'Confirm password',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 134, 123, 123)),
                                    ),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 16, 13, 13)),
                                    onChanged: (a) =>
                                        setState(() => _confirmPassword = a),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(32),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FloatingActionButton.extended(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              label: const Row(
                                children: [
                                  Text(
                                    "Create",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 10.0, left: 20),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: _addAccount,
                              heroTag: 'addAccountBtn',
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
