// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names, camel_case_types

import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/db/identity.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/custom_fields_editor.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:app/pmp/widgets/enum_dropdown_button_form_field.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/screens/edit_custom_field_screen.dart';
import 'package:app/screens/identities_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'identity_screen.dart';

class EditIdentityScreen extends StatefulWidget {
  const EditIdentityScreen({Key? key}) : super(key: key);

  static const routeName = '${IdentityScreen.routeName}/edit';

  @override
  State<StatefulWidget> createState() => _EditIdentityScreen();
}

class _EditIdentityScreen extends State<EditIdentityScreen> {
  bool _isLoaded = false;
  bool _isNew = true;

  String? _key;
  List<CustomField> _customFields = [];
  String _additionalInfo = '';
  List<String> _tags = [];
  String _nickname = '';
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  id.Title _title = id.Title.mr;
  id.Gender _gender = id.Gender.male;
  String _email = '';
  String _number = '';
  String _firstAddressLine = '';
  String _secondAddressLine = '';
  String _zipCode = '';
  String _city = '';
  String _country = '';

  @override
  Widget build(BuildContext context) {
    void _onSave() {
      final LoadedAccount account = data.loadedAccount!;
      _customFields.removeWhere((element) => element.value == '');
      Identity identityArgs = Identity(
        key: _key,
        customFields: _customFields,
        additionalInfo: _additionalInfo,
        tags: _tags,
        nickname: _nickname,
        title: _title,
        firstName: _firstName,
        middleName: _middleName,
        lastName: _lastName,
        gender: _gender,
        email: _email,
        number: _number,
        firstAddressLine: _firstAddressLine,
        secondAddressLine: _secondAddressLine,
        zipCode: _zipCode,
        city: _city,
        country: _country,
      );
      account.setIdentity(identityArgs);
      Navigator.pushNamed(context, SplashScreen.routeName);
      account.saveIdentities().whenComplete(() {
        Navigator.popUntil(
            context, (r) => r.settings.name == MainScreen.routeName);
        Navigator.pushNamed(context, IdentitiesScreen.routeName);
        Navigator.pushNamed(context, IdentityScreen.routeName,
            arguments: identityArgs);
      });
    }

    if (!_isLoaded) {
      Object? args = ModalRoute.of(context)!.settings.arguments;
      _isNew = args == null;
      if (!_isNew) {
        id.Identity identityArgs = args as id.Identity;
        _key = identityArgs.key;
        _customFields = List<CustomField>.from(identityArgs.customFields.map(
            (e) => CustomField(
                title: e.title,
                fieldType: e.fieldType,
                value: e.value,
                obscured: e.obscured)));
        _additionalInfo = identityArgs.additionalInfo;
        _tags = identityArgs.tags;
        _nickname = identityArgs.nickname;
        _title = identityArgs.title;
        _firstName = identityArgs.firstName;
        _middleName = identityArgs.middleName;
        _lastName = identityArgs.lastName;
        _gender = identityArgs.gender;
        _email = identityArgs.email;
        _number = identityArgs.number;
        _firstAddressLine = identityArgs.firstAddressLine;
        _secondAddressLine = identityArgs.secondAddressLine;
        _zipCode = identityArgs.zipCode;
        _city = identityArgs.city;
        _country = identityArgs.country;
      }
      _isLoaded = true;
    }

    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'identity',
        isNew: _isNew,
        onSave: _onSave,
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
        PmpPadding(EnumDropDownButtonFormField<id.Title>(
          value: _title,
          values: id.Title.values,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Color.fromARGB(255, 27, 27, 27)),
              labelText: 'Title'),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            if (value != null) setState(() => _title = value);
          },
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _firstName,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'First name'),
          onChanged: (value) => setState(() => _firstName = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _middleName,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Middle name'),
          onChanged: (value) => setState(() => _middleName = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _lastName,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Last name'),
          onChanged: (value) => setState(() => _lastName = value.trim()),
        )),
        PmpPadding(EnumDropDownButtonFormField<id.Gender>(
          value: _gender,
          values: id.Gender.values,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Gender'),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            if (value != null) setState(() => _gender = value);
          },
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _email,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Email'),
          onChanged: (value) => setState(() => _email = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _number,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Number'),
          onChanged: (value) => setState(() => _number = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _firstAddressLine,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'First address line'),
          onChanged: (value) =>
              setState(() => _firstAddressLine = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _secondAddressLine,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Second address line'),
          onChanged: (value) =>
              setState(() => _secondAddressLine = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _zipCode,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Zip code'),
          onChanged: (value) => setState(() => _zipCode = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _city,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'City'),
          onChanged: (value) => setState(() => _city = value.trim()),
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
          initialValue: _additionalInfo,
          decoration: InputDecoration(
            labelText: 'Additional info',
            labelStyle: const TextStyle(color: Colors.black),
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
