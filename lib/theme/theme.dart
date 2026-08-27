import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4EABC7)),
    appBarTheme: const AppBarTheme(
        toolbarHeight: 50,
        elevation: 5,
        shape: ContinuousRectangleBorder(side: BorderSide(color: Color(0xFF4EABC7)), borderRadius: BorderRadiusGeometry.all(Radius.circular(20))),
        centerTitle: true,
        backgroundColor: Color(0xFF4EABC7),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25)),
  );

}