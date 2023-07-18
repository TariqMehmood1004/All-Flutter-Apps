import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color light = Color(0xFFe9e8ed);

  static const Color transparent = Color(0x00000000);
  static const Color offYellow = Color(0xfff5eee3);

  static const Color blueAccentColor = Color(0xFF0067B8);
  static const Color offLightColor = Color(0xFFF2F2F2);
  static const Color contentCardColor = Color(0xFFD9E9F5);
  static const Color clickEventTextColor = Color(0xFF757575);
  static const Color navColor = Color(0xFF262626);
  static const Color footerForeColor = Color(0xFF616161);
  static const Color offBlueColor = Color(0xFFF1F1FF);
  static const Color foreColorOffBlueBg = Color(0xFF2E2E40);
  static const Color accentBlueColor = Color(0xFF5553FF);
  static const Color accentColor = Color(0xff29A0A6);
  static const Color accentColor2 = Color(0xffb6dde7);

  // Gradients
  static const LinearGradient background1 = LinearGradient(
    colors: [Color(0x4772E6A4), Color(0x9972E6A4)],
    stops: [0.1, 0.6],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(135 * 3.1415926 / 180),
  );

  static const LinearGradient background2 = LinearGradient(
    colors: [Color(0x22DD7DCF), Color(0x597D7DCF)],
    stops: [0.1, 0.35],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(135 * 3.1415926 / 180),
  );

  static const LinearGradient background3 = LinearGradient(
    colors: [Color(0x3CF29888), Color(0x99F29888)],
    stops: [0.1, 0.6],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(135 * 3.1415926 / 180),
  );

  // Font Sizes
  static const double h2FontSize = 2.3125 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h3FontSize = 1.0000 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h4FontSize = 1.1000 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h5FontSize = 1.1500 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h6FontSize = 1.1875 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h7FontSize = 1.1975 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h8FontSize = 2.0000 * 16.0; // Assuming 1rem = 16.0 pixels
  static const double h9FontSize = 2.1500 * 16.0; // Assuming 1rem = 16.0 pixels

  // Font Weights
  static const FontWeight fw100 = FontWeight.w100;
  static const FontWeight fw200 = FontWeight.w200;
  static const FontWeight fw300 = FontWeight.w300;
  static const FontWeight fw400 = FontWeight.w400;
  static const FontWeight fw500 = FontWeight.w500;
  static const FontWeight fw600 = FontWeight.w600;

  // Fonts
  static const String roboto = 'Roboto';
  static const String openSans = 'OpenSans';
  static const String montserrat = 'Montserrat';
}
