import 'package:app/pmp/widgets/entries_screen_appbar.dart';
import 'package:flutter/material.dart';
import '../common/common.dart';
import '../db/identity.dart';
import '../pmp/widgets/identity_button_list_view.dart';
import 'identity_screen.dart';
import 'main_screen.dart';
import 'search_screen.dart';
import 'edit_identity_screen.dart';

class IdentitiesScreen extends StatefulWidget {
  const IdentitiesScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/identities';

  @override
  State<StatefulWidget> createState() => _IdentitiesScreen();
}

class _IdentitiesScreen extends State<IdentitiesScreen> {
  final _account = data.loadedAccount!;

  void _onAddPressed() =>
      Navigator.pushNamed(context, EditIdentityScreen.routeName);

  void _onSearchPressed() {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: (String terms) {
      final List<Identity> found = [];
      // ignore: no_leading_underscores_for_local_identifiers
      final List<String> _terms = terms.trim().toLowerCase().split(' ');
      for (Identity identity in _account.identities) {
        {
          bool testIdentity(Identity value) => identity.key == value.key;

          if (found.any(testIdentity)) continue;
        }
        {
          int positiveCount = 0;
          for (String term in _terms) {
            if (identity.firstAddressLine.toLowerCase().contains(term)) {
              positiveCount++;
              continue;
            }
            if (identity.nickname.toLowerCase().contains(term)) {
              positiveCount++;
              continue;
            }
          }
          if (positiveCount == _terms.length) {
            found.add(identity);
          }
        }
      }
      return IdentityButtonListView(
        identities: found,
        shouldSort: true,
        onPressed: (identity) => Navigator.pushNamed(
          context,
          IdentityScreen.routeName,
          arguments: identity,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EntriesScreenAppBar(
          title: const Center(
              child: Text('Identities',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ))),
          onSearchPressed: _onSearchPressed,
          onAddPressed: _onAddPressed),
      body: _account.identities.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: [
                      const Spacer(flex: 7),
                      const Text(
                        'No identities',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                          child: const Icon(Icons.add_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pushNamed(
                              context, EditIdentityScreen.routeName)),
                      const Spacer(flex: 7),
                    ],
                  ),
                ),
              ],
            )
          : IdentityButtonListView(
              identities: _account.identities.toList(),
              shouldSort: true,
              onPressed: (identity) => Navigator.pushNamed(
                context,
                IdentityScreen.routeName,
                arguments: identity,
              ),
            ),
    );
  }
}
