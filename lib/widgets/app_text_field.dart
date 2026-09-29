import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.light = false,
    this.scale = 1.0,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool light;
  final double scale;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final Color fillColor = widget.light
        ? const Color(0xFFF3F5F9)
        : Colors.white.withValues(alpha: 0.08);
    final Color borderColor = widget.light
        ? const Color(0xFFE1E5EE)
        : Colors.white.withValues(alpha: 0.18);
    final Color textColor = widget.light
        ? const Color(0xFF0F1B33)
        : Colors.white;
    final Color iconColor = widget.light
        ? const Color(0xFF6B7690)
        : Colors.white70;
    final Color hintColor = widget.light
        ? const Color(0xFF9AA3B8)
        : Colors.white54;
    final double s = widget.scale;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      style: TextStyle(color: textColor, fontSize: 15 * s),
      cursorColor: iconColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: hintColor, fontSize: 15 * s),
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(widget.icon, color: iconColor, size: 20 * s),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: iconColor,
                  size: 20 * s,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16 * s,
          horizontal: 16 * s,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF25C8FB), width: 1.4),
        ),
      ),
    );
  }
}
