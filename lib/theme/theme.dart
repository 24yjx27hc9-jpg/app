import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4EABC7)),
    textTheme: TextTheme(
        labelMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
  );

}