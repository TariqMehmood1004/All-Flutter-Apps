import 'package:app/db/loaded_account.dart';
import 'package:app/db/password.dart';
import 'package:app/db/search.dart';
import 'package:app/pmp/widgets/entries_screen_appbar.dart';
import 'package:app/pmp/widgets/password_button_list_view.dart';
import 'package:flutter/material.dart';
import '../common/common.dart';
import 'edit_password_screen.dart';
import 'main_screen.dart';
import 'password_screen.dart';
import 'search_screen.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/passwords';

  @override
  State<StatefulWidget> createState() => _PasswordsScreen();
}

class _PasswordsScreen extends State<PasswordsScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  void _onAddPressed() =>
      Navigator.pushNamed(context, EditPasswordScreen.routeName);

  Widget _buildPasswords(String terms) {
    List<Password> found =
        Search.searchPasswords(passwords: _account.passwords, terms: terms);
    return PasswordButtonListView(
      passwords: found,
      onPressed: (password) => Navigator.pushNamed(
          context, PasswordScreen.routeName,
          arguments: password),
      shouldSort: true,
    );
  }

  void _onSearchPressed() {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: _buildPasswords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EntriesScreenAppBar(
          title: const Center(
              child: Text('Passwords',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ))),
          onSearchPressed: _onSearchPressed,
          onAddPressed: _onAddPressed),
      body: _account.passwords.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: [
                      const Spacer(flex: 7),
                      const Text(
                        'No passwords',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, EditPasswordScreen.routeName)),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ],
            )
          : PasswordButtonListView(
              passwords: _account.passwords.toList(),
              onPressed: (password) => Navigator.pushNamed(
                  context, PasswordScreen.routeName,
                  arguments: password),
              shouldSort: true,
            ),
    );
  }
}
