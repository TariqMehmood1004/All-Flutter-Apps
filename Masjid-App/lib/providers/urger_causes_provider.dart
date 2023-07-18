import 'package:flutter/material.dart';

class UrgentCausesSlider {
  var urgentCauses = [
    "Masjid Donation is a one-stop-shop for all your needs.",
    "Their donation is a one-stop-shop for all your needs.",
    "Human donate the money to the Masjid.",
  ];

  var urgentDescription = [
    "Python is a high-level, general-purpose programming language. Its design philosophy emphasizes code.",
    "C++ is a general-purpose programming language.",
    "Flutter is a cross-platform, open source UI library.",
  ];

  var urgentCausesImages = [
    "assets/images/masjid-1.jpg",
    "assets/images/funding.png",
    "assets/images/d3.png",
    "assets/images/donation.png",
  ];

  var gradientColor = [
    // Gradients
    const LinearGradient(
      colors: [Color(0x4772E6A4), Color(0x9972E6A4)],
      stops: [0.1, 0.6],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(135 * 3.1415926 / 180),
    ),

    const LinearGradient(
      colors: [Color(0x22DD7DCF), Color(0x597D7DCF)],
      stops: [0.1, 0.35],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(135 * 3.1415926 / 180),
    ),

    const LinearGradient(
      colors: [Color(0x3CF29888), Color(0x99F29888)],
      stops: [0.1, 0.6],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(135 * 3.1415926 / 180),
    ),
  ];

  var tabs = [
    'Home',
    'About Us',
    'Contact Us',
    'FAQ',
    'Terms & Conditions',
  ];

  var masjidImages = [
    "assets/images/masjid-1.jpg",
    "assets/images/masjid-2.jpg",
    "assets/images/masjid-3.jpg",
    "assets/images/masjid-4.jpg",
    "assets/images/masjid-5.jpg",
    "assets/images/masjid-6.jpg",
    "assets/images/masjid-7.jpg",
  ];

  var isClickedFavorite = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
}
