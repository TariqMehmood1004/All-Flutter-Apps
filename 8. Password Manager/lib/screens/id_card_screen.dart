// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/db/id_card.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/custom_field_button.dart';
import 'package:app/pmp/widgets/entry_screen_appbar.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/record_button.dart';
import 'package:flutter/material.dart';
import '../db/loaded_account.dart';
import 'edit_id_card_screen.dart';
import 'id_cards_screen.dart';
import 'main_screen.dart';

class IDCardScreen extends StatefulWidget {
  const IDCardScreen({Key? key}) : super(key: key);

  static const routeName = '/idCard';

  @override
  State<StatefulWidget> createState() => _IDCardScreen();
}

class _IDCardScreen extends State<IDCardScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  @override
  Widget build(BuildContext context) {
    final IDCard idCard = ModalRoute.of(context)!.settings.arguments as IDCard;

    void _onRemovePressed() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: PmpTheme.dialogShape,
              title: const Text('Remove ID card'),
              content:
                  const Text('ID cards can only be restored from a backup.'),
              actions: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 239, 245, 248)),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Color.fromARGB(255, 223, 227, 230)),
                  ),
                  onPressed: () {
                    _account.removeIDCard(idCard.key);
                    Navigator.popUntil(context,
                        (r) => r.settings.name == MainScreen.routeName);
                    _account.saveIDCards().whenComplete(() =>
                        Navigator.pushNamed(context, IDCardsScreen.routeName));
                  },
                )
              ],
            );
          });
    }

    void _onEditPressed() {
      Navigator.pushNamed(
        context,
        EditIDCardScreen.routeName,
        arguments: idCard,
      );
    }

    return Scaffold(
      appBar: EntryScreenAppBar(
        title: const Center(
            child: Text('ID card',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                ))),
        onRemovePressed: () => _onRemovePressed(),
        onEditPressed: () => _onEditPressed(),
      ),
      body: ListView(
        children: [
          if (idCard.nickname != '')
            PmpPadding(RecordButton(
              title: 'Nickname',
              value: idCard.nickname,
            )),
          if (idCard.type != '')
            PmpPadding(RecordButton(
              title: 'Type',
              value: idCard.type,
            )),
          if (idCard.idNumber != '')
            PmpPadding(RecordButton(
              title: 'ID Number',
              value: idCard.idNumber,
            )),
          if (idCard.name != '')
            PmpPadding(RecordButton(
              title: 'Name',
              value: idCard.name,
            )),
          if (idCard.country != '')
            PmpPadding(RecordButton(title: 'Country', value: idCard.country)),
          for (CustomField customField in idCard.customFields)
            PmpPadding(CustomFieldButton(customField: customField)),
          if (idCard.additionalInfo != '')
            PmpPadding(RecordButton(
                title: 'Additional info', value: idCard.additionalInfo)),
        ],
      ),
    );
  }
}
