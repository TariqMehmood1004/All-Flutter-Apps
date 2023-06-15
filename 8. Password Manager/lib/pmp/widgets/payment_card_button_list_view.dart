import 'package:app/db/payment_card.dart';
import 'package:app/pmp/sort.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:app/pmp/widgets/payment_card_button.dart';
import 'package:flutter/material.dart';

class PaymentCardButtonListView extends StatelessWidget {
  final List<PaymentCard> paymentCards;
  final bool shouldSort;
  final void Function(PaymentCard paymentCard)? onPressed;

  const PaymentCardButtonListView({
    Key? key,
    required this.paymentCards,
    this.shouldSort = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shouldSort) Sort.sortPaymentCards(paymentCards);
    return ListView(
      children: [
        for (PaymentCard paymentCard in paymentCards)
          PmpPadding(PaymentCardButton(
            paymentCard: paymentCard,
            onPressed: () => onPressed?.call(paymentCard),
          )),
      ],
    );
  }
}
