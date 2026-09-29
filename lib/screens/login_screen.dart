import 'package:flutter/material.dart';

import '../widgets/glass_login_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide >= 600;
    // Scale the card up on large tablet canvases so it doesn't look tiny
    // against the background; phones use the design's base size as-is.
    final double scale = isTablet
        ? (size.shortestSide / 800).clamp(1.1, 1.4)
        : 1.0;
    final double cardMaxWidth = isTablet ? 420 * scale : 400;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('asset/bg_login.png', fit: BoxFit.cover),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardMaxWidth),
                  child: GlassLoginCard(scale: scale),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
