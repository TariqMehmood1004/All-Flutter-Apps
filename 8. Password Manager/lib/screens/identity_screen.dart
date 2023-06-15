// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/db/identity.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/pmp/common/common.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/custom_field_button.dart';
import 'package:app/pmp/widgets/entry_screen_appbar.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'edit_identity_screen.dart';
import 'identities_screen.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({Key? key}) : super(key: key);

  static const routeName = '/identity';

  @override
  State<StatefulWidget> createState() => _IdentityScreen();
}

class _IdentityScreen extends State<IdentityScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  @override
  Widget build(BuildContext context) {
    final Identity identity =
        ModalRoute.of(context)!.settings.arguments as Identity;

    void _onRemovePressed() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: PmpTheme.dialogShape,
            title: const Text('Remove identity'),
            content:
                const Text('Identities can only be restored from a backup.'),
            actions: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 237, 242, 245)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Color.fromARGB(255, 241, 247, 249)),
                ),
                onPressed: () {
                  _account.removeIdentity(identity.key);
                  Navigator.popUntil(
                      context, (r) => r.settings.name == MainScreen.routeName);
                  _account.saveIdentities().whenComplete(() =>
                      Navigator.pushNamed(context, IdentitiesScreen.routeName));
                },
              )
            ],
          );
        },
      );
    }

    void _onEditPressed() {
      Navigator.pushNamed(
        context,
        EditIdentityScreen.routeName,
        arguments: identity,
      );
    }

    return Scaffold(
      appBar: EntryScreenAppBar(
        title: const Center(
            child: Text('Identity',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 250, 250),
                ))),
        onRemovePressed: _onRemovePressed,
        onEditPressed: _onEditPressed,
      ),
      body: ListView(
        children: [
          if (identity.nickname != '')
            PmpPadding(RecordButton(
              title: 'Nickname',
              value: identity.nickname,
            )),
          PmpPadding(RecordButton(
              title: 'Title', value: capitalize(identity.title.name))),
          if (identity.firstName != '')
            PmpPadding(RecordButton(
              title: 'First name',
              value: identity.firstName,
            )),
          if (identity.middleName != '')
            PmpPadding(RecordButton(
              title: 'Middle name',
              value: identity.middleName,
            )),
          if (identity.lastName != '')
            PmpPadding(RecordButton(
              title: 'Last name',
              value: identity.lastName,
            )),
          PmpPadding(RecordButton(
            title: 'Gender',
            value: capitalize(identity.gender.name),
          )),
          if (identity.email != '')
            PmpPadding(RecordButton(
              title: 'Email',
              value: identity.email,
            )),
          if (identity.number != '')
            PmpPadding(RecordButton(
              title: 'Number',
              value: identity.number,
            )),
          if (identity.firstAddressLine != '')
            PmpPadding(RecordButton(
                title: 'First address line', value: identity.firstAddressLine)),
          if (identity.secondAddressLine != '')
            PmpPadding(RecordButton(
                title: 'Second address line',
                value: identity.secondAddressLine)),
          if (identity.zipCode != '')
            PmpPadding(RecordButton(
              title: 'Zip code',
              value: identity.zipCode,
            )),
          if (identity.city != '')
            PmpPadding(RecordButton(
              title: 'City',
              value: identity.city,
            )),
          if (identity.country != '')
            PmpPadding(RecordButton(
              title: 'Country',
              value: identity.country,
            )),
          for (CustomField customField in identity.customFields)
            PmpPadding(CustomFieldButton(customField: customField)),
          if (identity.additionalInfo != '')
            PmpPadding(RecordButton(
                title: 'Additional info', value: identity.additionalInfo)),
        ],
      ),
    );
  }
}
