import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:flutter/material.dart';
import '../db/id_card.dart';
import '../db/loaded_account.dart';
import '../pmp/theme.dart';
import '../pmp/widgets/custom_fields_editor.dart';
import '../pmp/widgets/padding.dart';
import 'edit_custom_field_screen.dart';
import 'id_cards_screen.dart';
import 'splash_screen.dart';
import 'id_card_screen.dart';
import 'main_screen.dart';

class EditIDCardScreen extends StatefulWidget {
  const EditIDCardScreen({Key? key}) : super(key: key);

  static const routeName = '${IDCardScreen.routeName}/editIDCard';

  @override
  State<StatefulWidget> createState() => _EditIDCardScreen();
}

class _EditIDCardScreen extends State<EditIDCardScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  bool _isLoaded = false;
  bool _isNew = false;

  String? _key;
  List<CustomField> _customFields = [];
  String _additionalInfo = '';
  List<String> _tags = [];
  String _nickname = '';
  List<String> _pictures = [];
  String _type = '';
  String _idNumber = '';
  String _name = '';
  String _issDate = '';
  String _expDate = '';
  String _country = '';

  void _onSave() {
    IDCard idCardArgs = IDCard(
      key: _key,
      customFields: _customFields,
      additionalInfo: _additionalInfo,
      tags: _tags,
      nickname: _nickname,
      pictures: _pictures,
      type: _type,
      idNumber: _idNumber,
      name: _name,
      issDate: _issDate,
      expDate: _expDate,
      country: _country,
    );
    _account.setIDCard(idCardArgs);
    Navigator.pushNamed(context, SplashScreen.routeName);
    _account.saveIDCards().whenComplete(() {
      Navigator.popUntil(
          context, (r) => r.settings.name == MainScreen.routeName);
      Navigator.pushNamed(context, IDCardsScreen.routeName);
      Navigator.pushNamed(context, IDCardScreen.routeName,
          arguments: idCardArgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      Object? args = ModalRoute.of(context)!.settings.arguments;
      _isNew = args == null;
      if (!_isNew) {
        IDCard idCardArgs = args as IDCard;
        _key = idCardArgs.key;
        _customFields = idCardArgs.customFields
            .map((e) => CustomField(
                title: e.title,
                fieldType: e.fieldType,
                value: e.value,
                obscured: e.obscured))
            .toList();
        _additionalInfo = idCardArgs.additionalInfo;
        _tags = idCardArgs.tags;
        _nickname = idCardArgs.nickname;
        _pictures = idCardArgs.pictures;
        _type = idCardArgs.type;
        _idNumber = idCardArgs.idNumber;
        _name = idCardArgs.name;
        _issDate = idCardArgs.issDate;
        _expDate = idCardArgs.expDate;
        _country = idCardArgs.country;
      }
      _isLoaded = true;
    }

    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'ID card',
        onSave: _onSave,
        isNew: _isNew,
      ),
      body: ListView(children: [
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _nickname,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Nickname'),
          onChanged: (value) => setState(() => _nickname = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _type,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Type'),
          onChanged: (value) => setState(() => _type = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _idNumber,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'ID number'),
          onChanged: (value) => setState(() => _idNumber = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _name,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Name'),
          onChanged: (value) => setState(() => _name = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _country,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Country'),
          onChanged: (value) => setState(() => _country = value.trim()),
        )),
        CustomFieldsEditor(
          customFields: _customFields,
          shouldSort: true,
          padding: PmpTheme.Padding,
          constructCustomField: () async => (await Navigator.pushNamed(
            context,
            EditCustomFieldScreen.routeName,
          )) as CustomField?,
        ),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            labelText: 'Additional info',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: PmpTheme.lightContentColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide:
                  const BorderSide(color: PmpTheme.darkContentSecondaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: PmpTheme.lightContentColor),
            ),
          ),
          onChanged: (value) => setState(() => _additionalInfo = value),
        )),
      ]),
    );
  }
}
