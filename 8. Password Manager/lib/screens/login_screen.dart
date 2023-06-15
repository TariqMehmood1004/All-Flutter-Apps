// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app/common/common.dart';
import 'package:app/db/common.dart';
import 'package:app/db/password.dart';
import 'package:app/db/screen.dart';
import 'package:app/db/search.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/password_button_list_view.dart';
import 'package:app/screens/remove_account_screen.dart';
import 'package:app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:flutter_secure_screen/flutter_secure_screen.dart';
import '../common/assets.dart';
import '../db/loaded_account.dart';
import 'add_account_screen.dart';
import 'common.dart';
import 'global_settings_screen.dart';
import 'main_screen.dart';
import 'log_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool autofillLogin;

  const LoginScreen({Key? key, this.autofillLogin = false}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> with WidgetsBindingObserver {
  static bool didRun = false;
  Widget? _floatingActionButton;
  String _password = '';
  String _username = data.info.value.lastUsername;

  Future<void> _onResumed() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (data.getBioAuthEnabled(_username) ?? false) {
        if (await bioAuth(_username)) {
          Navigator.popUntil(
              context, (route) => route.settings.name == LoginScreen.routeName);
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
          LoadedAccount account = data.loadedAccount!;
          if (account.defaultScreen != Screen.main) {
            Navigator.pushNamed(
                context, screenToRouteName[account.defaultScreen]!);
          }
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) _onResumed();
  }

  Widget _buildPasswords(String terms) {
    List<Password> found = Search.searchPasswords(
        passwords: data.loadedAccount!.passwords, terms: terms);
    List<PwDataset> dbSets = [];
    return PasswordButtonListView(
      passwords: found,
      onPressed: (password) async {
        found.remove(password);
        found.insert(0, password);
        for (Password password in found) {
          dbSets.add(PwDataset(
            label: password.nickname,
            username: password.username,
            password: password.password,
          ));
        }
        await AutofillService().resultWithDatasets(dbSets);
        Navigator.pop(context);
      },
      shouldSort: true,
    );
  }

  void login() {
    if (getHash(_password).toString() != data.getPasswordHash(_username)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(
          Icons.lock_rounded,
          color: PmpTheme.darkContentColor,
        ),
        SizedBox(width: 20),
        Expanded(
            child: Text('Incorrect password',
                style: TextStyle(
                    color: Color.fromARGB(255, 251, 251, 251),
                    fontWeight: FontWeight.w500))),
      ])));
      return;
    }
    data.info.value.lastUsername = _username;
    data.info.save().whenComplete(() async {
      try {
        LoadedAccount account = data.loadAccount(
            data.info.value.lastUsername, getEncrypter(_password));
        if (widget.autofillLogin) {
          Navigator.pushNamed(
            context,
            SearchScreen.routeName,
            arguments: _buildPasswords,
          );
          return;
        }
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
        if (account.defaultScreen == Screen.main) return;
        Navigator.pushNamed(context, screenToRouteName[account.defaultScreen]!);
      } catch (e, s) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: const Row(children: [
              Icon(Icons.lock_rounded, color: PmpTheme.darkContentColor),
              SizedBox(width: 20),
              Text('Could not login'),
            ]),
            action: SnackBarAction(
              label: 'Details',
              onPressed: () => Navigator.pushNamed(context, LogScreen.routeName,
                  arguments: '$e\n$s'),
            ),
          ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if ((Platform.isAndroid || Platform.isIOS) && !widget.autofillLogin) {
      FlutterSecureScreen.singleton.setAndroidScreenSecure(true);
      _floatingActionButton = Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () =>
              Navigator.pushNamed(context, GlobalSettingsScreen.routeName),
          child: const Icon(
            Icons.settings_rounded,
            color: Colors.white,
          ),
        ),
      );
    }
    WidgetsBinding.instance.addObserver(this);
    if (didRun) return;
    didRun = true;
    _onResumed();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> usernames = data.usernames
        .map<DropdownMenuItem<String>>((username) => DropdownMenuItem(
              value: username,
              child: Row(children: [
                Expanded(child: Text(username)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      RemoveAccountScreen.routeName,
                      arguments: username,
                    );
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                  splashRadius: PmpTheme.appBarButtonSplashRadius,
                  padding: PmpTheme.appBarButtonPadding,
                ),
              ]),
            ))
        .toList();

    return Scaffold(
      floatingActionButton: _floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(flex: 1),
                logo60Purple,
                const Text(
                  'Password Manager Pro',
                  style: TextStyle(
                      color: Color.fromARGB(255, 185, 88, 39),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Text(
                  'Login Now',
                  style: TextStyle(
                      color: Color.fromARGB(255, 185, 88, 39),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 10,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _username,
                                    items: usernames,
                                    selectedItemBuilder: (context) {
                                      return usernames.map<Widget>((item) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            item.value!,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onChanged: (a) {
                                      setState(() => _username = a!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 16, 13, 13)),
                                    obscureText: true,
                                    onChanged: (a) =>
                                        setState(() => _password = a),
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 134, 123, 123)),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(32),
                                    ],
                                    autofocus: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () => login(),
                                  label: const Row(
                                    children: [
                                      Text(" Login ",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color.fromARGB(
                                                  255, 252, 252, 252)))
                                    ],
                                  ),
                                  heroTag: null,
                                ),
                                const SizedBox(
                                  width: 34,
                                ),
                                FloatingActionButton.extended(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, AddAccountScreen.routeName),
                                  label: const Row(
                                    children: [
                                      Text("Create",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color.fromARGB(
                                                  255, 252, 252, 252)))
                                    ],
                                  ),
                                  heroTag: 'addAccountBtn',
                                ),
                              ],
                            )
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
        ],
      ),
    );
  }
}
