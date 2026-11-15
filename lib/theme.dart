import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0A0E16);
  static const surface = Color(0xFF111827);
  static const surfaceAlt = Color(0xFF161F31);
  static const border = Color(0xFF1F2A3D);
  static const accent = Color(0xFF54C5F8);
  static const accentDeep = Color(0xFF0175C2);
  static const text = Color(0xFFE6EDF7);
  static const muted = Color(0xFF94A3B8);
  static const success = Color(0xFF34D399);
}

class AppText {
  static const display = TextStyle(
    fontSize: 60,
    height: 1.08,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
    letterSpacing: -1.5,
  );
  static const displayMobile = TextStyle(
    fontSize: 38,
    height: 1.12,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
    letterSpacing: -0.8,
  );
  static const h2 = TextStyle(
    fontSize: 40,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    letterSpacing: -0.8,
  );
  static const h2Mobile = TextStyle(
    fontSize: 30,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    letterSpacing: -0.5,
  );
  static const h3 = TextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );
  static const body = TextStyle(fontSize: 16, height: 1.7, color: AppColors.muted);
  static const bodyLarge = TextStyle(fontSize: 19, height: 1.65, color: AppColors.muted);
  static const small = TextStyle(fontSize: 14, height: 1.5, color: AppColors.muted);
  static const eyebrow = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.2,
    color: AppColors.accent,
  );
  static const chip = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  );
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
        primary: AppColors.accent,
        surface: AppColors.surface,
      ),
    );
    const shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );
    const padding = EdgeInsets.symmetric(horizontal: 22, vertical: 18);
    const label = TextStyle(fontWeight: FontWeight.w700, fontSize: 15);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.accent.withValues(alpha: 0.3),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.bg,
          padding: padding,
          shape: shape,
          textStyle: label,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          side: const BorderSide(color: AppColors.border),
          padding: padding,
          shape: shape,
          textStyle: label,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.muted,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5),
        ),
      ),
    );
  }
}
