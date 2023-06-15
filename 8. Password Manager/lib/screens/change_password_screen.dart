import 'package:app/common/common.dart';
import 'package:app/db/common.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/buttoned_text_form_field.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/screens/credentials_screen.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName =
      '${CredentialsScreen.routeName}/changePassword';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  String _password = '';
  String _newPassword = '';
  String _newPasswordConfirm = '';

  void _onConfirmPressed() {
    if (getHash(_password).toString() !=
        data.getPasswordHash(_account.username)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(
          Icons.lock_rounded,
          color: PmpTheme.darkContentColor,
        ),
        SizedBox(width: 20),
        Expanded(child: Text('Incorrect password')),
      ])));
      return;
    }
    if (_newPassword.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.lock_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Password is empty'),
      ])));
      return;
    }
    if (_newPassword != _newPasswordConfirm) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(children: [
        Icon(Icons.lock_rounded, color: PmpTheme.darkContentColor),
        SizedBox(width: 20),
        Text('Passwords do not match'),
      ])));
      return;
    }
    Navigator.pushNamed(context, SplashScreen.routeName);
    _account.setAccountPassword(_newPassword);
    _account.save().then((value) {
      Navigator.popUntil(context,
          (route) => route.settings.name == CredentialsScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        title: const Text('Change password',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
        leading: IconButton(
          padding: PmpTheme.appBarButtonPadding,
          splashRadius: PmpTheme.appBarButtonSplashRadius,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              RichText(
                text: TextSpan(
                    text: 'You\'re changing password for ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 21, 20, 20),
                    ),
                    children: [
                      TextSpan(
                        text: _account.username,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 7, 8, 8),
                        ),
                      ),
                      const TextSpan(text: '.')
                    ]),
              ),
              Expanded(
                child: PmpPadding(
                  Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 10, 10, 10),
                            ),
                            labelText: 'Current password'),
                        obscureText: true,
                        onChanged: (s) => setState(() => _password = s),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 10, 10, 10),
                        ),
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 10, 10, 10),
                            ),
                            labelText: 'New password'),
                        obscureText: true,
                        onChanged: (s) => setState(() => _newPassword = s),
                      ),
                      ButtonedTextFormField(
                        labelText: 'Confirm password',
                        obscureText: true,
                        onChanged: (s) =>
                            setState(() => _newPasswordConfirm = s),
                        onPressed: _onConfirmPressed,
                        buttonIcon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}
