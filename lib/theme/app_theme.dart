import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Matrix-style colors
  static const Color matrixGreen = Color(0xFF00FF00);
  static const Color darkGreen = Color(0xFF008F00);
  static const Color matrixBlack = Color(0xFF000000);
  static const Color terminalBlack = Color(0xFF0D0D0D);
  static const Color lightGreen = Color(0xFF40FF40);
  static const Color dimGreen = Color(0xFF004000);
  static const Color brightGreen = Color(0xFF80FF80);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      
      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: matrixGreen,
        secondary: darkGreen,
        surface: terminalBlack,
        onSurface: matrixGreen,
        onPrimary: matrixBlack,
        onSecondary: matrixBlack,
        tertiary: lightGreen,
        error: Colors.red,
        onError: Colors.white,
        surfaceContainerHighest: dimGreen,
      ),
      
      // Background
      scaffoldBackgroundColor: matrixBlack,
      
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: matrixBlack,
        foregroundColor: matrixGreen,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.sourceCodePro(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: matrixGreen,
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sourceCodePro(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: matrixGreen,
          letterSpacing: 1.2,
        ),
        displayMedium: GoogleFonts.sourceCodePro(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: matrixGreen,
          letterSpacing: 1.1,
        ),
        displaySmall: GoogleFonts.sourceCodePro(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: matrixGreen,
          letterSpacing: 1.0,
        ),
        headlineLarge: GoogleFonts.sourceCodePro(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: lightGreen,
          letterSpacing: 0.8,
        ),
        headlineMedium: GoogleFonts.sourceCodePro(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: lightGreen,
          letterSpacing: 0.7,
        ),
        headlineSmall: GoogleFonts.sourceCodePro(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: lightGreen,
          letterSpacing: 0.6,
        ),
        titleLarge: GoogleFonts.sourceCodePro(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: matrixGreen,
          letterSpacing: 0.5,
        ),
        titleMedium: GoogleFonts.sourceCodePro(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: matrixGreen,
          letterSpacing: 0.4,
        ),
        titleSmall: GoogleFonts.sourceCodePro(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: darkGreen,
          letterSpacing: 0.3,
        ),
        bodyLarge: GoogleFonts.sourceCodePro(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: matrixGreen,
          letterSpacing: 0.2,
        ),
        bodyMedium: GoogleFonts.sourceCodePro(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: matrixGreen,
          letterSpacing: 0.1,
        ),
        bodySmall: GoogleFonts.sourceCodePro(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkGreen,
          letterSpacing: 0.1,
        ),
        labelLarge: GoogleFonts.sourceCodePro(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: brightGreen,
          letterSpacing: 0.2,
        ),
        labelMedium: GoogleFonts.sourceCodePro(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: brightGreen,
          letterSpacing: 0.1,
        ),
        labelSmall: GoogleFonts.sourceCodePro(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: darkGreen,
          letterSpacing: 0.1,
        ),
      ),
      
      // Elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: matrixGreen,
          side: const BorderSide(color: matrixGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.sourceCodePro(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: terminalBlack,
        elevation: 4,
        shadowColor: matrixGreen.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: darkGreen, width: 1),
        ),
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: matrixGreen,
        size: 24,
      ),
    );
  }

  // Custom text styles for specific use cases
  static TextStyle get terminalPrompt => GoogleFonts.sourceCodePro(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: matrixGreen,
    letterSpacing: 0.5,
  );

  static TextStyle get terminalCommand => GoogleFonts.sourceCodePro(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: lightGreen,
    letterSpacing: 0.3,
  );

  static TextStyle get terminalOutput => GoogleFonts.sourceCodePro(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: brightGreen,
    letterSpacing: 0.2,
  );

  static TextStyle get logoText => GoogleFonts.sourceCodePro(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: matrixGreen,
    letterSpacing: 2.0,
  );

  static TextStyle get companyText => GoogleFonts.sourceCodePro(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: darkGreen,
    letterSpacing: 1.0,
  );
}
