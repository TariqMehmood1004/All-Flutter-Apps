import 'package:app/db/password.dart';
import 'package:app/pmp/sort.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/password_button.dart';
import 'package:flutter/material.dart';

class PasswordButtonListView extends StatelessWidget {
  final List<Password> passwords;
  final bool shouldSort;
  final void Function(Password password)? onPressed;

  const PasswordButtonListView({
    Key? key,
    required this.passwords,
    this.shouldSort = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shouldSort) Sort.sortPasswords(passwords);
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: [
        for (Password password in passwords)
          PmpPadding(PasswordButton(
            password: password,
            onPressed: () => onPressed?.call(password),
          )),
      ],
    );
  }
}
