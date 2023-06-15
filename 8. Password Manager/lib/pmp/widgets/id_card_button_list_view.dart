import 'package:app/db/id_card.dart';
import 'package:app/pmp/sort.dart';
import 'package:app/pmp/widgets/id_card_button.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';

class IDCardButtonListView extends StatelessWidget {
  final List<IDCard> idCards;
  final bool shouldSort;
  final void Function(IDCard idCard)? onPressed;

  const IDCardButtonListView({
    Key? key,
    required this.idCards,
    this.shouldSort = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shouldSort) Sort.sortIDCards(idCards);
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: [
        for (IDCard idCard in idCards)
          PmpPadding(IDCardButton(
            idCard: idCard,
            onPressed: () => onPressed?.call(idCard),
          )),
      ],
    );
  }
}
