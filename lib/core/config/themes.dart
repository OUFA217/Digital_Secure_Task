import 'package:flutter/material.dart';

abstract class Themes {
  static const Color yellowOrange = Color.fromARGB(255, 251, 177, 59);
  static const Color white = Colors.white;

  static const Color colorfulRed = Color.fromARGB(255, 255, 43, 43);
  static const Color blue = Color.fromRGBO(13, 119, 226, 1);

  static ThemeData lightTheme = ThemeData(
      textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'SfCompactDisplayLight',
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'SfCompactDisplaySemibold',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Tajawal-Light.ttf',
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'SfCompactDisplayRegular',
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.white),
    headlineSmall: TextStyle(
        fontFamily: 'SfCompactBold',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    titleLarge: TextStyle(
        fontFamily: 'SfCompactRegular',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white),
    headlineLarge: TextStyle(
        letterSpacing: 2,
        fontFamily: 'SfCompactDisplayBold',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white),
  ));
}
