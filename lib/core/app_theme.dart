import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Soft Pastel Palette
  // Soft Pastel Palette
  // Replaced "dim" cream with brighter off-white/white
  static const Color creamBackground = Color(0xFFFAFAFA);
  static const Color primaryOrange = Color(0xFFFFAB91); // Soft Peach/Orange
  static const Color primaryDark = Color(
    0xFFD84315,
  ); // Darker orange for text/accents
  static const Color softBrown = Color(
    0xFF5D4037,
  ); // Darker brown for better contrast
  static const Color darkText = Color(0xFF3E2723); // Almost black brown
  static const Color lightText = Color(0xFF757575);
  static const Color cardWhite = Colors.white;
  static const Color accentGreen = Color(
    0xFF43A047,
  ); // Vibrant Green for success/rating

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: creamBackground,
      primaryColor: primaryOrange,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        primary: primaryOrange,
        secondary: softBrown,
        surface: creamBackground, // Use cream for surface background
      ),

      // Typography
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: darkText,
        displayColor: darkText,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: creamBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryOrange, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: lightText.withValues(alpha: 0.7)),
      ),
    );
  }
}
