import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/shell_screen.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  final bool isInitialLogin;
  const AuthScreen({super.key, required this.isInitialLogin});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isLogin;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isInitialLogin;
  }

  void _toggleAuth() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShellScreen(
      child: Container(
        color: const Color(0xFFFEF6F9), // Light pinkish-white uniform background
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Logo Area
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63), // Matched the pink color from the image e market logo
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'O',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ojas',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'SHOP SMART',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Card Container
                Container(
                  width: 480,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isLogin
                        ? LoginForm(key: const ValueKey('login'), onToggle: _toggleAuth)
                        : RegisterForm(key: const ValueKey('register'), onToggle: _toggleAuth),
                  ),
                ),
                
                const SizedBox(height: 40),
                Text(
                  'By creating an account, you agree to our terms and conditions',
                  style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
