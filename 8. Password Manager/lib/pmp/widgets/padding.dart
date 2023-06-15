import 'package:app/pmp/theme.dart';
import 'package:flutter/material.dart';

class PmpPadding extends StatelessWidget {
  final Widget? child;

  const PmpPadding(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: PmpTheme.Padding,
        child: child,
      );
}
