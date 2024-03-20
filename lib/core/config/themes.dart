import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Themes {
  static const Color yellowOrange = Color.fromARGB(255, 251, 177, 59);
  static const Color white = Colors.white;

  static const Color colorfulRed = Color.fromARGB(255, 255, 43, 43);
  static const Color blue = Color.fromRGBO(13, 119, 226, 1);

  static ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'SfCompactDisplayLight',
          fontSize: 24.sp,
          fontWeight: FontWeight.w300,
          color: Colors.black),
      displayMedium: TextStyle(
          fontFamily: 'SfCompactDisplaySemibold',
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black),
      displaySmall: TextStyle(
          fontFamily: 'SfCompactDisplayBold',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      headlineMedium: TextStyle(
          fontFamily: 'SfCompactDisplayRegular',
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      headlineSmall: TextStyle(
          fontFamily: 'SfCompactBold',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      titleLarge: TextStyle(
          fontFamily: 'SfCompactRegular',
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      headlineLarge: TextStyle(
          fontFamily: 'TajwalLight',
          fontSize: 15.sp,
          fontWeight: FontWeight.w300,
          color: Colors.white),
    ),
  );

  static ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'SfCompactDisplayLight',
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'SfCompactDisplaySemibold',
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Tajawal-Light.ttf',
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'SfCompactDisplayRegular',
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white),
    headlineSmall: TextStyle(
        fontFamily: 'SfCompactBold',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    titleLarge: TextStyle(
        fontFamily: 'SfCompactRegular',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white),
    headlineLarge: TextStyle(
        fontFamily: 'SfCompactDisplayBold',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white),
  ));
}
