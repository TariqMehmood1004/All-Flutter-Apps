import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/db/password.dart';
import 'package:app/db/tfa.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/buttoned_text_form_field.dart';
import 'package:app/pmp/widgets/custom_fields_editor.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:app/pmp/widgets/enum_dropdown_button_form_field.dart';
import 'package:app/pmp/widgets/string_generator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';
import '../pmp/widgets/padding.dart';
import 'edit_custom_field_screen.dart';
import 'password_screen.dart';
import 'splash_screen.dart';
import 'main_screen.dart';
import 'passwords_screen.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '${PasswordScreen.routeName}/edit';

  @override
  State<StatefulWidget> createState() => _EditPasswordScreen();
}

class _EditPasswordScreen extends State<EditPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoaded = false;
  bool _isNew = true;

  String? _key;
  List<CustomField> _customFields = [];
  String _additionalInfo = '';
  List<String> _tags = [];
  String _nickname = '';
  String _username = '';
  String _email = '';
  String _password = '';
  String _tfaSecret = '';
  int _tfaLength = 6;
  int _tfaInterval = 30;
  Algorithm _tfaAlgorithm = Algorithm.SHA1;
  bool _tfaIsGoogle = true;
  String _website = '';

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      Object? args = ModalRoute.of(context)!.settings.arguments;
      _isNew = args == null;
      if (!_isNew) {
        Password passwordArgs = args as Password;
        TFA? tfa = passwordArgs.tfa;
        _key = passwordArgs.key;
        _customFields = List<CustomField>.from(passwordArgs.customFields.map(
            (e) => CustomField(
                title: e.title,
                fieldType: e.fieldType,
                value: e.value,
                obscured: e.obscured,
                multiline: e.multiline)));
        _additionalInfo = passwordArgs.additionalInfo;
        _tags = passwordArgs.tags;
        _nickname = passwordArgs.nickname;
        _username = passwordArgs.username;
        _email = passwordArgs.email;
        _password = passwordArgs.password;
        _passwordController.text = _password;
        if (tfa != null) {
          _tfaSecret = tfa.secret;
          _tfaLength = tfa.length;
          _tfaInterval = tfa.interval;
          _tfaAlgorithm = tfa.algorithm;
          _tfaIsGoogle = tfa.isGoogle;
        }
        _website = passwordArgs.website;
      }
      _isLoaded = true;
    }

    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'password',
        isNew: _isNew,
        onSave: () {
          final LoadedAccount account = data.loadedAccount!;
          _customFields.removeWhere((element) => element.value == '');
          Password passwordArgs = Password(
            key: _key,
            customFields: _customFields,
            additionalInfo: _additionalInfo,
            tags: _tags,
            nickname: _nickname,
            username: _username,
            email: _email,
            password: _password,
            tfa: _tfaSecret == ''
                ? null
                : TFA(
                    secret: _tfaSecret,
                    length: _tfaLength,
                    interval: _tfaInterval,
                    algorithm: _tfaAlgorithm,
                    isGoogle: _tfaIsGoogle,
                  ),
            website: _website,
          );
          account.setPassword(passwordArgs);
          Navigator.pushNamed(context, SplashScreen.routeName);
          account.savePasswords().whenComplete(() {
            Navigator.popUntil(
                context, (r) => r.settings.name == MainScreen.routeName);
            Navigator.pushNamed(context, PasswordsScreen.routeName);
            Navigator.pushNamed(context, PasswordScreen.routeName,
                arguments: passwordArgs);
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          PmpPadding(TextFormField(
            initialValue: _nickname,
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: 'Nickname',
                labelStyle: TextStyle(color: Colors.black)),
            onChanged: (value) => setState(() => _nickname = value.trim()),
          )),
          PmpPadding(TextFormField(
            initialValue: _username,
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            decoration: const InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black),
              contentPadding:
                  EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
            ),
            onChanged: (value) => setState(() => _username = value.trim()),
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _email,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: 'Email'),
            onChanged: (value) => setState(() => _email = value.trim()),
          )),
          PmpPadding(ButtonedTextFormField(
            controller: _passwordController,
            labelText: 'Password',
            onChanged: (value) => setState(() => _password = value),
            buttonIcon: const Icon(
              Icons.password_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const StringGeneratorDialog(),
              ).then((value) {
                if (value == null) return;
                _passwordController.text = value;
                setState(() => _password = value);
              });
            },
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _tfaSecret.replaceFirst('=', ''),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: '2FA secret'),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-z]|[A-Z]|[2-7]')),
              TextInputFormatter.withFunction((oldValue, newValue) =>
                  TextEditingValue(
                      text: newValue.text.toUpperCase(),
                      selection: newValue.selection)),
            ],
            onChanged: (value) {
              if (value.length.isOdd) value += '=';
              setState(() => _tfaSecret = value);
            },
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _tfaLength.toString(),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: '2FA length'),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) => setState(() => _tfaLength = int.parse(value)),
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _tfaInterval.toString(),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: '2FA interval'),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) =>
                setState(() => _tfaInterval = int.parse(value)),
          )),
          PmpPadding(EnumDropDownButtonFormField<Algorithm>(
            value: _tfaAlgorithm,
            values: Algorithm.values,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: '2FA algorithm'),
            onChanged: (value) {
              if (value != null) setState(() => _tfaAlgorithm = value);
            },
          )),
          PmpPadding(DropdownButtonFormField(
            dropdownColor: PmpTheme.appbarcolor,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text(
                  'True (recommended).',
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
            value: _tfaIsGoogle,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: '2FA is Google'),
            onChanged: (value) => setState(() => _tfaIsGoogle = value as bool),
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _website,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
                labelText: 'Website'),
            onChanged: (value) => setState(() => _website = value),
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
              labelStyle: const TextStyle(color: Colors.black),
              contentPadding:
                  const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
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
      ),
    );
  }
}
