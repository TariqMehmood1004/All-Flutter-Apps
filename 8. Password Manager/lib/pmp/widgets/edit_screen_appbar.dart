import 'package:app/pmp/theme.dart';
import 'package:flutter/material.dart';

class EditScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  final EdgeInsetsGeometry buttonPadding;
  final double buttonSplashRadius;
  final String title;
  final Function()? onSave;
  final bool isNew;

  const EditScreenAppBar({
    Key? key,
    this.buttonPadding = PmpTheme.appBarButtonPadding,
    this.buttonSplashRadius = PmpTheme.appBarButtonSplashRadius,
    required this.title,
    this.onSave,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PmpTheme.appbarcolor,
      key: key,
      leading: IconButton(
        padding: buttonPadding,
        splashRadius: buttonSplashRadius,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: isNew
          ? Center(
              child: Text('Add $title',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  )))
          : Center(
              child: Text('Edit $title',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ))),
      actions: [
        IconButton(
          padding: buttonPadding,
          splashRadius: buttonSplashRadius,
          onPressed: onSave,
          icon: isNew
              ? const Icon(Icons.add_rounded, color: Colors.white)
              : const Icon(Icons.check_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
