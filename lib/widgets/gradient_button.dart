import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.scale = 1.0,
  });

  final String label;
  final VoidCallback onPressed;
  final bool loading;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final double s = scale;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: loading ? null : onPressed,
        child: Ink(
          height: 52 * s,
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: loading
                ? SizedBox(
                    height: 22 * s,
                    width: 22 * s,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.4,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8 * s),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18 * s,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
