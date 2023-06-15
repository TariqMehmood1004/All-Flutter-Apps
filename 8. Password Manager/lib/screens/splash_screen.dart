// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:app/common/common.dart';
import 'package:app/screens/add_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/';
  static bool loaded = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _load() async {
      data = await loadData();
      loaded = true;
      if (data.noAccounts) {
        // ignore: use_build_context_synchronously
        Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(
                context, AddAccountScreen.routeName));
        return;
      }
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, LoginScreen.routeName));
    }

    if (!loaded) {
      _load();
    }
    return Scaffold(
      body: Center(
        child: Container(child: Lottie.asset("assets/images/sp.json")),
      ),
    );
  }
}
