import 'package:flutter/material.dart';

/*заголовки → Manrope 700
основной текст → Inter 500
кнопки → Inter 600
мелкие подписи → Inter 400*/

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4EABC7)),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
      bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
      labelMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
      titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Manrope'),
      headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Manrope')
    ),
  );

}