// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ThemeCollection extends ChangeNotifier {
  /// _colorSwatch method or function take RGB color as argument and after processing
  ///  it will return Map<int, Color> where int consist colors varients
  Map<int, Color> _colorSwatch(
    int r,
    int g,
    int b,
  ) =>
      {
        50: Color.fromRGBO(r, g, b, 0.1),
        100: Color.fromRGBO(r, g, b, 0.2),
        200: Color.fromRGBO(r, g, b, 0.3),
        300: Color.fromRGBO(r, g, b, 0.4),
        400: Color.fromRGBO(r, g, b, 0.5),
        500: Color.fromRGBO(r, g, b, 0.6),
        600: Color.fromRGBO(r, g, b, 0.7),
        700: Color.fromRGBO(r, g, b, 0.8),
        800: Color.fromRGBO(r, g, b, 0.9),
        900: Color.fromRGBO(r, g, b, 1),
      };
  bool isDarkActive = true;

  void setDarkTheme(bool value) {
    isDarkActive = value;
    notifyListeners();
  }

  ThemeData get getActiveTheme => isDarkActive ? _darkTheme : _lightTheme;

// Let's define a light theme for our Application
  ThemeData get _lightTheme => ThemeData(
      primaryColor: const Color(0xff6622CC),
      hintColor: const Color(0xffAE77FF),
      canvasColor: const Color(0xffFFFFFF),
      iconTheme: const IconThemeData(color: Colors.black87),
      primaryTextTheme: TextTheme(
          bodyLarge: const TextStyle(color: Colors.black, fontSize: 15),
          bodyMedium: const TextStyle(color: Colors.black54, fontSize: 15),
          titleMedium: const TextStyle(color: Colors.black),
          displaySmall: const TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
          titleLarge: const TextStyle(color: Colors.black),
          bodySmall: TextStyle(
              color: Colors.grey.shade700, wordSpacing: -1, fontSize: 12)), colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(0xffFFFFFF, _colorSwatch(1, 117, 194))).copyWith(surface: const Color(0xffFFFFFF)));

// Now define a dark theme for our Application
  ThemeData get _darkTheme => ThemeData(
      primaryColor: const Color(0xff6622CC),
      hintColor: const Color(0xffAE77FF),
      canvasColor: const Color(0xff0B0415),
      iconTheme: const IconThemeData(color: Colors.white),
      primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 15),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 15),
          titleMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white),
          bodySmall:
              TextStyle(color: Colors.white54, wordSpacing: -1, fontSize: 12)), colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(0xff0B0415, _colorSwatch(2, 86, 155))).copyWith(surface: const Color(0xff0B0415)));
}
