import 'package:app/db/custom_field.dart';
import 'package:app/db/id_card.dart';
import 'package:app/db/identity.dart';
import 'package:app/db/note.dart';
import 'package:app/db/password.dart';
import 'package:app/db/payment_card.dart';
import 'common/common.dart';

class Sort {
  static void sortPasswords(List<Password> passwords) {
    passwords.sort((a, b) {
      int nickComp = alphabeticalCompare(a.nickname, b.nickname);
      if (nickComp == 0) {
        return alphabeticalCompare(a.username, b.username);
      }
      return nickComp;
    });
  }

  static void sortCustomFields(List<CustomField> customFields) {
    customFields.sort(
      (a, b) => alphabeticalCompare(a.title, b.title),
    );
  }

  static void sortPaymentCards(List<PaymentCard> paymentCards) {
    paymentCards.sort((a, b) {
      int nickComp = alphabeticalCompare(a.nickname, b.nickname);
      if (nickComp == 0) {
        return alphabeticalCompare(a.cardholderName, b.cardholderName);
      }
      return nickComp;
    });
  }

  static void sortNotes(List<Note> notes) =>
      notes.sort((a, b) => alphabeticalCompare(a.title, b.title));

  static void sortIDCards(List<IDCard> idCards) {
    idCards.sort((a, b) {
      int nickComp = alphabeticalCompare(a.nickname, b.nickname);
      if (nickComp == 0) {
        return alphabeticalCompare(a.name, b.name);
      }
      return nickComp;
    });
  }

  static void sortIdentities(List<Identity> identities) {
    identities.sort((a, b) {
      int nickComp = alphabeticalCompare(a.nickname, b.nickname);
      if (nickComp == 0) {
        return alphabeticalCompare(a.firstAddressLine, b.firstAddressLine);
      }
      return nickComp;
    });
  }
}
