import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customTheme() {
  return ThemeData(useMaterial3: true).copyWith(
    textTheme: GoogleFonts.lexendTextTheme(),
    //   colorScheme: ColorScheme.fromSeed(
    //     seedColor: Colors.lightGreen,
    //     primary: Colors.lightGreen.shade300,
    //     secondary: Colors.lightGreen.shade200,
    //     onPrimary: Colors.white,
    //     onSecondary: Colors.black87,
    //     surface: Colors.white,
    //     onSurface: Colors.black87,
    //   ),
    //   elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
    //   ),
    //   textTheme: TextTheme(
    //     headlineLarge: GoogleFonts.lexend(
    //       fontSize: 24,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     displayLarge: GoogleFonts.lexend(
    //       fontSize: 32,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     bodyLarge: GoogleFonts.lexend(fontSize: 18, color: Colors.black87),
    //     bodyMedium: GoogleFonts.lexend(fontSize: 16, color: Colors.black87),
    //     bodySmall: GoogleFonts.lexend(fontSize: 14, color: Colors.black87),
    //     labelLarge: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
    //     labelMedium: GoogleFonts.lexend(
    //       fontSize: 14,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     labelSmall: GoogleFonts.lexend(fontSize: 12, fontWeight: FontWeight.bold),
    //     titleLarge: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.bold),
    //     titleMedium: GoogleFonts.lexend(
    //       fontSize: 18,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     titleSmall: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
    //   ),
    //   appBarTheme: AppBarTheme(backgroundColor: Colors.lightGreen.shade300),
  );
}
