import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand
  static const primary = Color(0xFFD6BAFF);
  static const primaryContainer = Color(0xFFAB73FF);
  static const onPrimaryFixed = Color(0xFF280056);
  
  static const secondary = Color(0xFF9BE1FF);
  static const tertiary = Color(0xFF43D9E9);
  
  // Background & Surface
  static const background = Color(0xFF131315);
  static const onBackground = Color(0xFFE5E1E4);
  
  static const surface = Color(0xFF131315);
  static const onSurface = Color(0xFFE5E1E4);
  static const surfaceVariant = Color(0xFF353437);
  static const onSurfaceVariant = Color(0xFFCDC2D7);
  
  static const surfaceContainerLowest = Color(0xFF0E0E10);
  static const surfaceContainerLow = Color(0xFF1B1B1D);
  static const surfaceContainer = Color(0xFF201F21);
  static const surfaceContainerHigh = Color(0xFF2A2A2C);
  static const surfaceContainerHighest = Color(0xFF353437);
  
  // Outline & States
  static const outline = Color(0xFF968DA0);
  static const outlineVariant = Color(0xFF4B4454);
  static const error = Color(0xFFFFB4AB);
}

class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        background: AppColors.background,
        surface: AppColors.surface,
        onPrimary: const Color(0xFF430089),
        onSecondary: const Color(0xFF003545),
        onBackground: AppColors.onBackground,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        surfaceVariant: AppColors.surfaceVariant,
        error: AppColors.error,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w800,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w800,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.onSurface,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: GoogleFonts.inter(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.normal,
          letterSpacing: 2.0,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.onSurface,
      ),
    );
  }
}
