import 'package:flutter/material.dart';

class PmpTheme {
  // ignore: constant_identifier_names
  static const Padding = EdgeInsets.symmetric(vertical: 8, horizontal: 8);
  static const appBarButtonSplashRadius = 28.0;
  static const appBarButtonPadding = EdgeInsets.all(16.0);

  static const ShapeBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );
  static const darkContentColor = Color.fromARGB(255, 251, 252, 253);
  static const darkContentSecondaryColor = Color.fromRGBO(84, 110, 122, 1);
  static const lightContentColor = Color.fromARGB(255, 48, 53, 56);
  static const lightContentSecondaryColor = Color.fromARGB(255, 45, 47, 48);
  static const appbarcolor = Color.fromARGB(255, 225, 124, 94);

  static final ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 225, 124, 94),
      onPrimary: lightContentColor,
      secondary: Color.fromARGB(255, 220, 115, 83),
      onSecondary: lightContentColor,
      onSurface: lightContentColor,
    ),
    snackBarTheme: const SnackBarThemeData(
        actionTextColor: Color.fromARGB(255, 219, 232, 239)),
    scaffoldBackgroundColor: darkContentColor,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: lightContentSecondaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(
          color: darkContentSecondaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: lightContentColor)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor:
            MaterialStateProperty.resolveWith((states) => Colors.transparent),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: lightContentColor,
      selectionColor: lightContentSecondaryColor,
      selectionHandleColor: lightContentColor,
    ),
  );

  static const ColorScheme datePickerColorScheme = ColorScheme.dark(
    primary: lightContentSecondaryColor,
    onPrimary: lightContentColor,
  );
}
