import 'package:flutter/material.dart';

/// Categorical + status palette for the dashboard, drawn from the app's
/// validated data-viz palette. Slots 1/2/3 (blue/orange/aqua) are the ones
/// documented to clear all-pairs CVD checks, so the category donut chart
/// uses only those three plus neutral grey for "Lainnya". Icon tiles reuse
/// the same hues for visual consistency but aren't decoded as a legend.
class DashboardColors {
  DashboardColors._();

  static const Color pageBackground = Color(0xFFF3F5FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF14172B);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color divider = Color(0xFFE7E9F1);

  static const Color sidebarTop = Color(0xFF0B1E45);
  static const Color sidebarBottom = Color(0xFF12326E);

  static const Color blue = Color(0xFF2A78D6);
  static const Color orange = Color(0xFFEB6834);
  static const Color aqua = Color(0xFF1BAF7A);
  static const Color violet = Color(0xFF4A3AA7);
  static const Color magenta = Color(0xFFE87BA4);
  static const Color neutralOther = Color(0xFF9CA3AF);

  static const Color statusGood = Color(0xFF0CA30C);
  static const Color deltaUpGood = Color(0xFF006300);
}
