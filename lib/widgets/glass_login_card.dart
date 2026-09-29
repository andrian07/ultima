import 'dart:ui';

import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';
import '../theme/app_colors.dart';
import 'app_text_field.dart';
import 'gradient_button.dart';

class GlassLoginCard extends StatefulWidget {
  const GlassLoginCard({super.key, this.scale = 1.0});

  final double scale;

  @override
  State<GlassLoginCard> createState() => _GlassLoginCardState();
}

class _GlassLoginCardState extends State<GlassLoginCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  void _contactAdmin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hubungi administrator untuk membuat akun baru'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double s = widget.scale;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 50,
            offset: const Offset(0, 26),
          ),
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.2),
            blurRadius: 90,
            spreadRadius: -10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 36 * s,
                  vertical: 40 * s,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1C3E72).withValues(alpha: 0.55),
                      const Color(0xFF0A1B3D).withValues(alpha: 0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('asset/logo.png', height: 70 * s),
                    SizedBox(height: 12 * s),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 28 * s,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                        children: const [
                          TextSpan(
                            text: 'ULTIMA ',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'POS',
                            style: TextStyle(color: Color(0xFF25C8FB)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6 * s),
                    Text(
                      'SIMPLE  •  FAST  •  POWERFUL',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12 * s,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 32 * s),
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24 * s,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6 * s),
                    Text(
                      'Masuk untuk mengakses sistem',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14 * s),
                    ),
                    SizedBox(height: 28 * s),
                    AppTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      icon: Icons.person_outline,
                      scale: s,
                    ),
                    SizedBox(height: 14 * s),
                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      scale: s,
                    ),
                    SizedBox(height: 24 * s),
                    GradientButton(
                      label: 'Masuk',
                      loading: _loading,
                      onPressed: _handleLogin,
                      scale: s,
                    ),
                    SizedBox(height: 24 * s),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withValues(alpha: 0.24),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12 * s),
                          child: Text(
                            'atau',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12 * s,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withValues(alpha: 0.24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * s),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _contactAdmin,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * s,
                            vertical: 14 * s,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44 * s,
                                height: 44 * s,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF25D366,
                                  ).withValues(alpha: 0.15),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF25D366,
                                    ).withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Icon(
                                  Icons.chat_rounded,
                                  color: const Color(0xFF25D366),
                                  size: 22 * s,
                                ),
                              ),
                              SizedBox(width: 14 * s),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Belum punya akun?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14 * s,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2 * s),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13 * s,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'Silahkan hubungi ',
                                          ),
                                          TextSpan(
                                            text: 'administrator',
                                            style: TextStyle(
                                              color: const Color(0xFF25C8FB),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                                size: 22 * s,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 1.4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.55),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
