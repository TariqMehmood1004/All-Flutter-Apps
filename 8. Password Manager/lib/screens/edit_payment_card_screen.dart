import 'package:app/common/common.dart';
import 'package:app/db/custom_field.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/db/payment_card.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/custom_fields_editor.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:app/pmp/widgets/month_picker.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/payment_card_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_custom_field_screen.dart';
import 'main_screen.dart';
import 'payment_card_screen.dart';
import 'splash_screen.dart';
import 'payment_cards_screen.dart';

class EditPaymentCardScreen extends StatefulWidget {
  const EditPaymentCardScreen({Key? key}) : super(key: key);

  static const routeName = '${PaymentCardScreen.routeName}/editPaymentCard';

  @override
  State<StatefulWidget> createState() => _EditPaymentCardScreen();
}

class _EditPaymentCardScreen extends State<EditPaymentCardScreen> {
  bool _isLoaded = false;
  bool _isNew = false;

  String? _key;
  List<CustomField> _customFields = [];
  String _additionalInfo = '';
  List<String> _tags = [];
  String _nickname = '';
  String _cardNumber = '';
  String _cardholderName = '';
  String _cvv = '';
  String _exp = '';

  @override
  void initState() {
    super.initState();
    {
      DateTime date = DateTime.now().toUtc();
      String month = date.month.toString();
      String year = date.year.toString();
      if (month.length == 1) {
        month = '0$month';
      }
      _exp = '$month/$year';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      Object? args = ModalRoute.of(context)!.settings.arguments;
      _isNew = args == null;
      if (!_isNew) {
        PaymentCard paymentCardArgs = args as PaymentCard;
        _key = paymentCardArgs.key;
        _customFields = List<CustomField>.from(paymentCardArgs.customFields.map(
            (e) => CustomField(
                title: e.title,
                fieldType: e.fieldType,
                value: e.value,
                obscured: e.obscured)));
        _additionalInfo = paymentCardArgs.additionalInfo;
        _tags = paymentCardArgs.tags;
        _nickname = paymentCardArgs.nickname;
        _cardNumber = paymentCardArgs.cardNumber;
        _cardholderName = paymentCardArgs.cardholderName;
        _cvv = paymentCardArgs.cvv;
        _exp = paymentCardArgs.exp;
      }
      _isLoaded = true;
    }

    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'payment card',
        onSave: () {
          final LoadedAccount account = data.loadedAccount!;
          _customFields.removeWhere((element) => element.value == '');
          PaymentCard paymentCardArgs = PaymentCard(
            key: _key,
            customFields: _customFields,
            additionalInfo: _additionalInfo,
            tags: _tags,
            nickname: _nickname,
            cardNumber: _cardNumber,
            cardholderName: _cardholderName,
            cvv: _cvv,
            exp: _exp,
          );
          account.setPaymentCard(paymentCardArgs);
          Navigator.pushNamed(context, SplashScreen.routeName);
          account.savePaymentCards().whenComplete(() {
            Navigator.popUntil(
                context, (r) => r.settings.name == MainScreen.routeName);
            Navigator.pushNamed(context, PaymentCardsScreen.routeName);
            Navigator.pushNamed(context, PaymentCardScreen.routeName,
                arguments: paymentCardArgs);
          });
        },
        isNew: _isNew,
      ),
      body: ListView(
        children: [
          PaymentCardButton(
            paymentCard: PaymentCard(
              nickname: _nickname,
              cardNumber: _cardNumber,
              cardholderName: _cardholderName,
              exp: _exp,
              cvv: _cvv,
            ),
            obscureCardNumber: false,
            obscureCardCvv: false,
            isSwipeGestureEnabled: false,
          ),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _nickname,
            decoration: const InputDecoration(
              labelText: 'Nickname',
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) => setState(() => _nickname = value.trim()),
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _cardNumber,
            decoration: const InputDecoration(
              labelText: 'Card number',
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) => setState(() => _cardNumber = value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _cardholderName,
            decoration: const InputDecoration(
              labelText: 'Card holder name',
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) =>
                setState(() => _cardholderName = value.trim()),
          )),
          PmpPadding(MonthPickerFormField(
            initialValue: _exp,
            title: const Text(
              'Expiration date',
              style: TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            ),
            getSelectedDate: () {
              List<String> date = _exp.split('/');
              String month = date[0];
              String year = date[1];
              if (month[0] == '0') {
                month = month[1];
              }
              return DateTime.utc(int.parse(year), int.parse(month));
            },
            onChanged: (selectedDate) {
              String month = selectedDate.month.toString();
              String year = selectedDate.year.toString();
              if (month.length == 1) month = '0$month';
              setState(() {
                _exp = '$month/$year';
              });
            },
          )),
          PmpPadding(TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            initialValue: _cvv,
            decoration: const InputDecoration(
              labelText: 'CVV',
              labelStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) => setState(() => _cvv = value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
        ],
      ),
    );
  }
}
