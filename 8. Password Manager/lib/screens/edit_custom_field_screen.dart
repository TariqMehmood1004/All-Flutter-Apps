import 'package:app/db/custom_field.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:flutter/material.dart';

import '../pmp/widgets/padding.dart';


class EditCustomFieldScreen extends StatefulWidget {
  const EditCustomFieldScreen({Key? key}) : super(key: key);

  static const routeName = '/editCustomField';

  @override
  State<StatefulWidget> createState() => _EditCustomFieldScreen();
}

class _EditCustomFieldScreen extends State<EditCustomFieldScreen> {
  final CustomField _customField = CustomField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'custom field',
        onSave: () => Navigator.pop(context, _customField),
        isNew: true,
      ),
      body: ListView(children: [
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _customField.title,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              contentPadding:
                  EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
              labelText: 'Title'),
          onChanged: (value) => setState(() => _customField.title = value),
        )),
        PmpPadding(DropdownButtonFormField(
          dropdownColor: const Color.fromARGB(255, 244, 244, 244),
          items: [
            DropdownMenuItem(
              value: FieldType.text,
              child: Text(
                FieldType.text.name[0].toUpperCase() +
                    FieldType.text.name.substring(1),
                style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
            DropdownMenuItem(
              value: FieldType.number,
              child: Text(
                FieldType.number.name[0].toUpperCase() +
                    FieldType.number.name.substring(1),
                style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
            DropdownMenuItem(
              value: FieldType.password,
              child: Text(
                FieldType.password.name[0].toUpperCase() +
                    FieldType.password.name.substring(1),
                style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
            DropdownMenuItem(
              value: FieldType.date,
              child: Text(
                FieldType.date.name[0].toUpperCase() +
                    FieldType.date.name.substring(1),
                style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
          ],
          value: _customField.fieldType,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Type'),
          onChanged: (value) => _customField.fieldType = value as FieldType,
        )),
        PmpPadding(DropdownButtonFormField(
          dropdownColor: const Color.fromARGB(255, 244, 244, 244),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text(
                'True',
                style: TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
            DropdownMenuItem(
              value: false,
              child: Text(
                'False',
                style: TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
          ],
          value: _customField.obscured,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Obscured'),
          onChanged: (value) => _customField.obscured = value as bool,
        )),
        PmpPadding(DropdownButtonFormField(
          dropdownColor: const Color.fromARGB(255, 244, 244, 244),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text(
                'True',
                style: TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
            DropdownMenuItem(
              value: false,
              child: Text(
                'False',
                style: TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              ),
            ),
          ],
          value: _customField.obscured,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Multiline'),
          onChanged: (value) => _customField.multiline = value as bool,
        )),
      ]),
    );
  }
}
