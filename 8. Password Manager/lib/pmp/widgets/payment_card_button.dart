import 'package:app/db/payment_card.dart';
import 'package:app/pmp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentCardButton extends StatelessWidget {
  final PaymentCard paymentCard;
  final bool obscureCardNumber;
  final bool obscureCardCvv;
  final bool isSwipeGestureEnabled;
  final List<CustomCardTypeIcon>? customCardTypeIcons;
  final void Function()? onPressed;

  const PaymentCardButton({
    Key? key,
    required this.paymentCard,
    this.obscureCardNumber = true,
    this.obscureCardCvv = true,
    this.isSwipeGestureEnabled = false,
    this.customCardTypeIcons,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color.fromARGB(255, 27, 27, 27),
        Color.fromARGB(255, 46, 46, 46),
      ],
      stops: <double>[
        0.6,
        0,
      ],
    );
    return Center(
      child: Stack(
        children: [
          TextButton(
            onPressed: onPressed,
            child: CreditCardWidget(
              textStyle: const TextStyle(color: Colors.white),
              glassmorphismConfig:
                  Glassmorphism(blurX: 3.0, blurY: 5.0, gradient: gradient),
              width: 350,
              height: 200,
              cardNumber: beautifyCardNumber(
                paymentCard.cardNumber,
              ),

              expiryDate: paymentCard.exp,
              cardHolderName: paymentCard.cardholderName,
              customCardTypeIcons: customCardTypeIcons ??
                  [
                    CustomCardTypeIcon(
                        cardType: CardType.otherBrand,
                        cardImage: Image.asset(
                          'assets/images/icon.png',
                          width: 50,
                        ))
                  ],
              cvvCode: paymentCard.cvv,
              showBackView: false,
              obscureCardNumber: obscureCardNumber,
              obscureCardCvv: obscureCardCvv,
              isHolderNameVisible: true,
              isChipVisible: false,
              //backgroundImage: 'assets/images/icon.png',

              cardType: cardTypeFromNumber(paymentCard.cardNumber),
              isSwipeGestureEnabled: isSwipeGestureEnabled,
              onCreditCardWidgetChange: (brand) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 32, 0, 0),
            child: Text(
              paymentCard.nickname,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
