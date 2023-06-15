import 'package:app/db/custom_field.dart';
import 'package:app/pmp/common/common.dart';
import 'package:app/pmp/sort.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/string_generator_dialog.dart';
import 'package:app/pmp/widgets/threewidgetbtn2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFieldsEditor extends StatefulWidget {
  final List<CustomField> customFields;
  final bool shouldSort;
  final EdgeInsetsGeometry padding;
  final ColorScheme? datePickerColorScheme;
  final Future<CustomField?> Function() constructCustomField;

  const CustomFieldsEditor({
    Key? key,
    required this.customFields,
    this.shouldSort = false,
    this.padding = EdgeInsets.zero,
    this.datePickerColorScheme = PmpTheme.datePickerColorScheme,
    required this.constructCustomField,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomFieldsEditor();
}

class _CustomFieldsEditor extends State<CustomFieldsEditor> {
  @override
  void initState() {
    super.initState();
    if (widget.shouldSort) Sort.sortCustomFields(widget.customFields);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PmpPadding(ThreeWidgetBtn2(
          left: const Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.add_rounded),
          ),
          center: const Text('Add custom field'),
          onPressed: () {
            widget.constructCustomField().then((value) {
              if (value != null) {
                setState(() {
                  widget.customFields.add(value);
                  Sort.sortCustomFields(widget.customFields);
                });
              }
            });
          },
        )),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.customFields.length,
          itemBuilder: (context, index) {
            List<TextInputFormatter>? inputFormatters;
            CustomField field = widget.customFields[index];
            List<Widget> widgets = [];
            switch (field.fieldType) {
              case (FieldType.number):
                inputFormatters = [FilteringTextInputFormatter.digitsOnly];
                break;
              case (FieldType.date):
                widgets.add(
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => PmpshowDatePicker(
                      context: context,
                      date: field.value == ''
                          ? DateTime.now()
                          : stringToDate(field.value),
                    ).then(
                      (value) {
                        if (value == null) return;
                        setState(() => field.value = dateToString(value));
                      },
                    ),
                    child: const Icon(Icons.date_range),
                  ),
                );
                break;
              case (FieldType.password):
                widgets.add(
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const StringGeneratorDialog(),
                      ).then((value) {
                        if (value == null) return;
                        setState(() => field.value = value);
                      });
                    },
                    child: const Icon(
                      Icons.password_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
                break;
              default:
                break;
            }
            widgets.insert(
              0,
              Flexible(
                child: TextFormField(
                  style:
                      const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
                  inputFormatters: inputFormatters,
                  initialValue: field.value,
                  decoration: InputDecoration(
                    labelText: field.title,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide:
                          const BorderSide(color: PmpTheme.lightContentColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                          color: PmpTheme.darkContentSecondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide:
                          const BorderSide(color: PmpTheme.lightContentColor),
                    ),
                  ),
                  onChanged: (value) => field.value = value,
                  maxLines: field.multiline ? null : 1,
                ),
              ),
            );
            widgets.add(
              FloatingActionButton(
                heroTag: null,
                onPressed: () =>
                    setState(() => widget.customFields.removeAt(index)),
                child: const Icon(
                  Icons.remove_rounded,
                  color: Colors.white,
                ),
              ),
            );
            return Padding(
              padding: widget.padding,
              child: Row(
                key: UniqueKey(),
                children: widgets,
              ),
            );
          },
        ),
      ],
    );
  }
}
