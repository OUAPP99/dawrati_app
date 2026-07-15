import 'package:flutter/material.dart';

/// Semantic surface/text tokens that flip between light and dark mode.
/// Brand/accent colors (pink primary, purple, gold, chart colors) stay
/// literal across both themes on purpose — only backgrounds, cards and
/// text need to invert for dark mode to read correctly.
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
  });

  static const light = AppColorScheme(
    background: Color(0xFFFFF7FA),
    surface: Colors.white,
    surfaceAlt: Color(0xFFFFEAF3),
    textPrimary: Color(0xFF1F2937),
    textSecondary: Color(0xFF6B7280),
    divider: Color(0xFFEDEDED),
  );

  static const dark = AppColorScheme(
    background: Color(0xFF14101A),
    surface: Color(0xFF201A29),
    surfaceAlt: Color(0xFF2C2333),
    textPrimary: Color(0xFFF3F1F6),
    textSecondary: Color(0xFFA79FB3),
    divider: Color(0xFF362C40),
  );

  @override
  AppColorScheme copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textPrimary,
    Color? textSecondary,
    Color? divider,
  }) {
    return AppColorScheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

extension AppColorSchemeX on BuildContext {
  AppColorScheme get colors =>
      Theme.of(this).extension<AppColorScheme>() ?? AppColorScheme.light;
}
