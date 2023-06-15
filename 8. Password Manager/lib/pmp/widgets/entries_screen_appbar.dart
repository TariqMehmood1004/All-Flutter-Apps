import 'package:app/pmp/theme.dart';
import 'package:flutter/material.dart';

class EntriesScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  final EdgeInsetsGeometry buttonPadding;
  final double buttonSplashRadius;
  final Widget title;
  final void Function()? onSearchPressed;
  final void Function()? onAddPressed;

  const EntriesScreenAppBar({
    Key? key,
    this.buttonPadding = PmpTheme.appBarButtonPadding,
    this.buttonSplashRadius = PmpTheme.appBarButtonSplashRadius,
    required this.title,
    this.onSearchPressed,
    this.onAddPressed,
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
          onPressed: onSearchPressed,
          icon: const Icon(Icons.search_rounded, color: Colors.white),
        ),
        IconButton(
          padding: buttonPadding,
          splashRadius: buttonSplashRadius,
          onPressed: onAddPressed,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
