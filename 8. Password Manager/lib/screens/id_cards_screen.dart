import 'package:app/common/common.dart';
import 'package:app/db/id_card.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/pmp/widgets/entries_screen_appbar.dart';
import 'package:app/pmp/widgets/id_card_button_list_view.dart';
import 'package:flutter/material.dart';
import 'edit_id_card_screen.dart';
import 'id_card_screen.dart';
import 'main_screen.dart';
import 'search_screen.dart';

class IDCardsScreen extends StatefulWidget {
  const IDCardsScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/idCards';

  @override
  State<StatefulWidget> createState() => _IDCardsScreen();
}

class _IDCardsScreen extends State<IDCardsScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  void _onAddPressed() =>
      Navigator.pushNamed(context, EditIDCardScreen.routeName);

  void _onSearchPressed() {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: (String terms) {
      final List<IDCard> found = [];
      // ignore: no_leading_underscores_for_local_identifiers
      final List<String> _terms = terms.trim().toLowerCase().split(' ');
      for (IDCard idCard in _account.idCards) {
        {
          bool testIDCard(IDCard value) => idCard.key == value.key;

          if (found.any(testIDCard)) continue;
        }
        {
          int positiveCount = 0;
          // ignore: no_leading_underscores_for_local_identifiers
          for (String _term in _terms) {
            if (idCard.nickname.toLowerCase().contains(_term)) {
              positiveCount++;
              continue;
            }
            if (idCard.name.toLowerCase().contains(_term)) {
              positiveCount++;
              continue;
            }
          }
          if (positiveCount == _terms.length) {
            found.add(idCard);
          }
        }
      }
      return IDCardButtonListView(
        idCards: found,
        shouldSort: true,
        onPressed: (idCard) => Navigator.pushNamed(
          context,
          IDCardScreen.routeName,
          arguments: idCard,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EntriesScreenAppBar(
          title: const Center(
              child: Text('ID cards',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ))),
          onSearchPressed: _onSearchPressed,
          onAddPressed: _onAddPressed),
      body: _account.idCards.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: [
                      const Spacer(flex: 7),
                      const Text(
                        'No ID cards',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                          child: const Icon(Icons.add_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pushNamed(
                              context, EditIDCardScreen.routeName)),
                      const Spacer(flex: 7),
                    ],
                  ),
                ),
              ],
            )
          : IDCardButtonListView(
              idCards: _account.idCards.toList(),
              shouldSort: true,
              onPressed: (idCard) => Navigator.pushNamed(
                  context, IDCardScreen.routeName,
                  arguments: idCard),
            ),
    );
  }
}
