import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static final List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .05),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];

  static final List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .08),
      blurRadius: 30,
      offset: const Offset(0, 14),
    ),
  ];

  static final List<BoxShadow> pinkGlow = [
    BoxShadow(
      color: const Color(0xFFE91E63).withValues(alpha: .15),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
  ];
}