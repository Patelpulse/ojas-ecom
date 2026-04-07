import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/features/auth/application/auth_service.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onToggle;
  const RegisterForm({super.key, required this.onToggle});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;

  final AuthService _authService = AuthService();

  Future<void> _handleRegister() async {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms and privacy policy.')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      setState(() => _isLoading = true);

      final response = await _authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        gender: "other", // Dummy default value to satisfy API if needed
        mobile: _mobileController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (response.success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created! Please login.')),
          );
          widget.onToggle();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Create Account',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Join us and start your shopping journey',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          
          // Avatar Upload Circle
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.person_outline, size: 30, color: Color(0xFF94A3B8)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE91E63),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Fields
          _buildFieldLabel('Full Name'),
          _buildTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            icon: Icons.person_outline,
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),

          _buildFieldLabel('Email Address'),
          _buildTextField(
            controller: _emailController,
            hintText: 'Email... (e.g. rohitsengar@gmail.com)',
            icon: Icons.mail_outline,
            isFocusedFill: true, // as per the image
            validator: (v) => v!.isEmpty || !v.contains('@') ? 'Invalid email' : null,
          ),
          const SizedBox(height: 12),

          _buildFieldLabel('Mobile Number'),
          _buildTextField(
            controller: _mobileController,
            hintText: 'Enter your mobile number',
            icon: Icons.phone_outlined,
            validator: (v) => v!.length < 10 ? 'Invalid mobile' : null,
          ),
          const SizedBox(height: 12),

          _buildFieldLabel('Password'),
          _buildTextField(
            controller: _passwordController,
            hintText: '*********',
            icon: Icons.lock_outline,
            obscure: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF94A3B8), size: 18),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            isFocusedFill: true,
            validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password must contain uppercase, lowercase, and number',
                style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11),
              ),
            ),
          ),

          _buildFieldLabel('Confirm Password'),
          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm your password',
            icon: Icons.lock_outline,
            obscure: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF94A3B8), size: 18),
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 20),

          // Checkbox Terms
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _agreedToTerms,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  side: const BorderSide(color: Color(0xFF94A3B8)),
                  activeColor: const Color(0xFFE91E63),
                  onChanged: (v) => setState(() => _agreedToTerms = v!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'I agree to the ',
                    style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569)),
                    children: [
                      TextSpan(text: 'Terms of Service', style: GoogleFonts.inter(color: const Color(0xFFE91E63))),
                      const TextSpan(text: ' and '),
                      TextSpan(text: 'Privacy Policy', style: GoogleFonts.inter(color: const Color(0xFFE91E63))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Create Account', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),

          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 14)),
              InkWell(
                onTap: widget.onToggle,
                child: Text('Sign In', style: GoogleFonts.inter(color: const Color(0xFFE91E63), fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(0xFF334155)),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    bool isFocusedFill = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: GoogleFonts.inter(color: const Color(0xFF334155), fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 18),
        suffixIcon: suffixIcon,
        filled: isFocusedFill,
        fillColor: const Color(0xFFEEF2F6), // Match light blueish focus background seen in image
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: isFocusedFill ? Colors.transparent : const Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE91E63)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
