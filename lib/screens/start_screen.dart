import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _glowAnim = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.2,
            colors: [Color(0xFF3B0A0A), Color(0xFF1A0505), Color(0xFF0A0000)],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rose logo with glow
                AnimatedBuilder(
                  animation: _glowAnim,
                  builder: (context, child) => Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFB71C1C,
                          ).withValues(alpha: 0.35 * _glowAnim.value),
                          blurRadius: 70,
                          spreadRadius: 20,
                        ),
                        BoxShadow(
                          color: const Color(
                            0xFFFFD700,
                          ).withValues(alpha: 0.12 * _glowAnim.value),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: child,
                  ),
                  child: SvgPicture.asset(
                    'assets/Red_Rose_logo.svg',
                    width: 180,
                    height: 180,
                    colorFilter: const ColorFilter.matrix(<double>[
                      // R channel → red
                      -1, 0, 0, 0, 200,
                      // G channel → dark
                      0, 0, 0, 0, 10,
                      // B channel → dark
                      0, 0, 0, 0, 10,
                      // Alpha
                      0, 0, 0, 1, 0,
                    ]),
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "RED ROSE",
                  style: TextStyle(
                    color: Color(0xFFCC1111),
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 8,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "A CHOICE CHANGES EVERYTHING",
                  style: TextStyle(
                    color: Color(0xFF884444),
                    fontSize: 10,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 64),

                _MenuButton(
                  label: "BEGIN",
                  isPrimary: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  ),
                ),

                const SizedBox(height: 12),

                _MenuButton(
                  label: "SETTINGS",
                  isPrimary: false,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _MenuButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFFB71C1C) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPrimary
                ? const Color(0xFFE53935)
                : const Color(0xFF4A1515),
            width: 1,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFFB71C1C).withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isPrimary ? Colors.white : const Color(0xFF886666),
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
