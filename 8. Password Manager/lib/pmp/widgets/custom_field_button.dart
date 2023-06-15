import 'package:app/db/custom_field.dart';
import 'package:app/pmp/widgets/record_button.dart';
import 'package:flutter/material.dart';

class CustomFieldButton extends StatelessWidget {
  final CustomField customField;

  const CustomFieldButton({Key? key, required this.customField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecordButton(
      title: customField.title,
      value: customField.value,
      obscureValue: customField.obscured,
      isPassword: customField.fieldType == FieldType.password,
    );
  }
}
