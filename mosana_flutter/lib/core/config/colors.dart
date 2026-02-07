import 'package:flutter/material.dart';

/// AppColors - Mosana Design System Colors
class AppColors {
  AppColors._();
  
  // BRAND COLORS
  static const Color mosanaPurple = Color(0xFF4B2D8F);
  static const Color mosanaBlue = Color(0xFF4A7FD9);
  
  // BACKGROUNDS
  static const Color deepPurpleBlack = Color(0xFF0F0F1E);
  static const Color cardSurface = Color(0xFF1A1A2E);
  static const Color pureBlack = Color(0xFF000000);
  
  // TEXT
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA0A0B2);
  
  // BORDERS
  static const Color borderColor = Color(0xFF2A2A3E);
  
  // ACCENTS
  static const Color gold = Color(0xFFF59E0B);
  static const Color green = Color(0xFF10B981);
  static const Color red = Color(0xFFEF4444);
  
  // GRADIENTS
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mosanaPurple, mosanaBlue],
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, Color(0xFFD97706)],
  );
}
