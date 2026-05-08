import 'package:flutter/material.dart';

/// Cores centralizadas do America App (baseado no FlutterTemplates.dev).
class AppColors {
  AppColors._();

  static const Color primary = Colors.deepPurple;
  static const Color onPrimary = Colors.white;
  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color error = Colors.red;
  static const Color accent = Colors.deepPurpleAccent;
}

/// Tema centralizado do America App (FlutterTemplates.dev style).
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );

  static ThemeData get dark => ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );
}
