import 'package:flutter/material.dart';

class PromoColors {
  static const Color deepNavy = Color(0xFF0D1B2A);
  static const Color navy = Color(0xFF1B2838);
  static const Color charcoal = Color(0xFF2C3E50);
  static const Color steelGray = Color(0xFF546E7A);
  static const Color lightGray = Color(0xFF90A4AE);
  static const Color teal = Color(0xFF00897B);
  static const Color tealLight = Color(0xFF26A69A);
  static const Color tealAccent = Color(0xFF4DB6AC);
  static const Color surface = Color(0xFFF5F7FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E6ED);
  static const Color textPrimary = Color(0xFF1A2332);
  static const Color textSecondary = Color(0xFF5A6A7A);
  static const Color textOnDark = Color(0xFFE8EDF2);
  static const Color textMutedOnDark = Color(0xFFB0BEC5);
}

class PromoTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: PromoColors.teal,
      brightness: Brightness.light,
      primary: PromoColors.teal,
      onPrimary: Colors.white,
      surface: PromoColors.surface,
      onSurface: PromoColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: PromoColors.surface,
      fontFamily:
          'Pretendard, "Noto Sans KR", "Apple SD Gothic Neo", sans-serif',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          color: PromoColors.textOnDark,
          height: 1.25,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: PromoColors.textPrimary,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: PromoColors.textPrimary,
          height: 1.35,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: PromoColors.textPrimary,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: PromoColors.textPrimary,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: PromoColors.textSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: PromoColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: PromoColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: PromoColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PromoColors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PromoColors.textOnDark,
          side: const BorderSide(color: PromoColors.tealAccent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: PromoColors.navy.withValues(alpha: 0.6),
        labelStyle: const TextStyle(
          color: PromoColors.tealAccent,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(color: PromoColors.teal.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      ),
    );
  }
}

class PromoLayout {
  static const double maxContentWidth = 1200;
  static const double sectionPadding = 80;
  static const double sectionPaddingMobile = 40;
  static const double cardGap = 24;
  static const double cardGapMobile = 16;

  static EdgeInsets sectionPaddingOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width > 768 ? 48.0 : 20.0;
    final vertical = width > 768 ? sectionPadding : sectionPaddingMobile;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static int gridColumns(BuildContext context, {int max = 3}) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1024) return max;
    if (width > 640) return max > 2 ? 2 : max;
    return 1;
  }
}
