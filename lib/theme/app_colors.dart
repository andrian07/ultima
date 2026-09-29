import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color deepBlue = Color(0xFF061539);
  static const Color primaryBlue = Color(0xFF1565FF);
  static const Color accentCyan = Color(0xFF25C8FB);

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryBlue, accentCyan],
  );
}
