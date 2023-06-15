import 'package:app/pmp/theme.dart';
import 'package:flutter/material.dart';

class EntryScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  final EdgeInsetsGeometry buttonPadding;
  final double buttonSplashRadius;
  final Widget title;
  final void Function()? onRemovePressed;
  final void Function()? onEditPressed;

  const EntryScreenAppBar({
    Key? key,
    this.buttonPadding = PmpTheme.appBarButtonPadding,
    this.buttonSplashRadius = PmpTheme.appBarButtonSplashRadius,
    required this.title,
    this.onRemovePressed,
    this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PmpTheme.appbarcolor,
      leading: IconButton(
        padding: buttonPadding,
        splashRadius: buttonSplashRadius,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: title,
      actions: [
        IconButton(
          padding: buttonPadding,
          splashRadius: buttonSplashRadius,
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.white),
          onPressed: onRemovePressed,
        ),
        IconButton(
          padding: buttonPadding,
          splashRadius: buttonSplashRadius,
          icon: const Icon(Icons.edit_rounded, color: Colors.white),
          onPressed: onEditPressed,
        ),
      ],
    );
  }
}
