

import 'package:app/pmp/theme.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

String capitalize(String string) {
  if (string.isEmpty) return '';
  String firstLetter = string[0].toUpperCase();
  if (string.length == 1) return firstLetter;
  return '$firstLetter${string.substring(1)}';
}

CardType cardTypeFromCreditCardType(CreditCardType cardType) {
  switch (cardType) {
    case CreditCardType.visa:
      return CardType.visa;
    case CreditCardType.mastercard:
      return CardType.mastercard;
    case CreditCardType.americanExpress:
      return CardType.americanExpress;
    case CreditCardType.discover:
      return CardType.discover;
    default:
      return CardType.otherBrand;
  }
}

CardType cardTypeFromNumber(String number) =>
    cardTypeFromCreditCardType(detectCCType(number) as CreditCardType);

String beautifyCardNumber(String cardNumber) {
  if (cardNumber.isEmpty) {
    return '';
  }
  String value = cardNumber.trim();
  cardNumber = value[0];
  for (int i = 1; i < value.length; i++) {
    if (i % 4 == 0) cardNumber += ' ';
    cardNumber += value[i];
  }
  return cardNumber;
}

int alphabeticalCompare(String a, String b) =>
    a.toLowerCase().compareTo(b.toLowerCase());

String dateToString(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

DateTime stringToDate(String value) {
  if (value == '') return DateTime.now();
  List<String> dateSplit = value.split('/');
  if (dateSplit.length == 3) return DateTime.now();
  return DateTime(
    int.parse(dateSplit[2]),
    int.parse(dateSplit[1]),
    int.parse(dateSplit[0]),
  );
}

// ignore: non_constant_identifier_names
Future<DateTime?> PmpshowDatePicker(
    {required BuildContext context,
    required DateTime date,
    ColorScheme colorScheme = PmpTheme.datePickerColorScheme}) {
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: DateTime.utc(0, 04, 20),
    lastDate: DateTime.utc(275760, 09, 13),
    builder: (context, w) => Theme(
      data: ThemeData(colorScheme: colorScheme),
      child: w!,
    ),
  );
}
