import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class BecomeVendorPage extends StatefulWidget {
  const BecomeVendorPage({super.key});

  @override
  State<BecomeVendorPage> createState() => _BecomeVendorPageState();
}

class _BecomeVendorPageState extends State<BecomeVendorPage> {
  int _currentStep = 0; // 0: Personal Info, 1: Business Info, etc.
  bool _isLogin = true; // Added toggle state

  void _nextStep() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _toggleMode(bool login) {
    setState(() {
      _isLogin = login;
      if (!login) _currentStep = 0; // Reset steps when switching
    });
  }

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'BECOME VENDOR',
      child: CenteredContent(
        child: Column(
          children: [
            const SizedBox(height: 80),
            
            // 1. Header Section
            if (!_isLogin)
              Text(
                'Become a vendor',
                style: GoogleFonts.outfit(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
            if (!_isLogin) const SizedBox(height: 16),
            Text(
              _isLogin 
                  ? 'Access your vendor dashboard to manage your products, orders, and business analytics.'
                  : 'Join thousands of successful vendors on our platform and grow your business with us.\nStart selling to customers worldwide today!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            
            // 2. Toggle Buttons
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _toggleMode(false),
                    child: _ToggleButton(title: 'Become a Vendor', isActive: !_isLogin),
                  ),
                  GestureDetector(
                    onTap: () => _toggleMode(true),
                    child: _ToggleButton(title: 'Login', isActive: _isLogin),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Main Dynamic Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isLogin ? _buildLoginForm() : _buildRegistrationFlow(),
            ),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xFFFCE7F3), // Soft pink
            child: const Icon(Icons.person_outline, size: 36, color: Color(0xFFE91E63)),
          ),
          const SizedBox(height: 24),
          Text(
            'Vendor Login',
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 8),
          Text(
            'Access your vendor dashboard',
            style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 48),

          // Fields
          _buildAuthFieldLabel('Email Address'),
          _buildAuthTextField(
            hintText: 'rohitsengar@gmail.com',
            icon: Icons.mail_outline,
            isFocusedFill: true,
          ),
          const SizedBox(height: 24),

          _buildAuthFieldLabel('Password'),
          _buildAuthTextField(
            hintText: '••••••••••',
            icon: Icons.lock_outline,
            obscure: true,
            suffixIcon: const Icon(Icons.visibility_outlined, color: Color(0xFF94A3B8), size: 18),
            isFocusedFill: true,
          ),
          const SizedBox(height: 32),

          // Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign In to Dashboard', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account? ', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13)),
              InkWell(
                onTap: () => _toggleMode(false),
                child: Text('Become a Vendor', style: GoogleFonts.inter(color: const Color(0xFFE91E63), fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Text('Forgot your password?', style: GoogleFonts.inter(color: const Color(0xFFE91E63), fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(0xFF334155)),
        ),
      ),
    );
  }

  Widget _buildAuthTextField({
    required String hintText,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    bool isFocusedFill = false,
  }) {
    return TextFormField(
      obscureText: obscure,
      style: GoogleFonts.inter(color: const Color(0xFF334155), fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF0F172A), fontSize: 14), // Using darker hint to match mock
        prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 18),
        suffixIcon: suffixIcon,
        filled: isFocusedFill,
        fillColor: const Color(0xFFEEF2F6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: isFocusedFill ? Colors.transparent : const Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE91E63)),
        ),
      ),
    );
  }

  Widget _buildRegistrationFlow() {
    return Column(
      children: [
        // 3. Benefits Grid
        Row(
          children: [
            _BenefitCard(
              icon: Icons.attach_money_rounded,
              title: 'Competitive Commission',
              description: 'Low fees with transparent pricing structure',
            ),
            _BenefitCard(
              icon: Icons.public_rounded,
              title: 'Global Reach',
              description: 'Access to customers in 25+ countries',
            ),
            _BenefitCard(
              icon: Icons.security_rounded,
              title: 'Secure Payments',
              description: 'Fast and secure payment processing',
            ),
            _BenefitCard(
              icon: Icons.star_outline_rounded,
              title: 'Marketing Support',
              description: 'Promotional tools and marketing assistance',
            ),
          ],
        ),
        const SizedBox(height: 60),
        
        // 4. Progress bar section
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[100]!),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 20, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              // Progress Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StepItem(icon: Icons.person, label: 'Personal Info', subLabel: 'Your personal details', isActive: _currentStep == 0, isCompleted: _currentStep > 0),
                  _StepItem(icon: Icons.business, label: 'Business Info', subLabel: 'Business information', isActive: _currentStep == 1, isCompleted: _currentStep > 1),
                  _StepItem(icon: Icons.inventory_2_outlined, label: 'Products', subLabel: 'Product details', isActive: _currentStep == 2, isCompleted: _currentStep > 2),
                  _StepItem(icon: Icons.description_outlined, label: 'Documents', subLabel: 'Required documents', isActive: _currentStep == 3, isCompleted: _currentStep > 3),
                  _StepItem(icon: Icons.check_circle_outline, label: 'Review', subLabel: 'Review & submit', isActive: _currentStep == 4),
                ],
              ),
              const SizedBox(height: 60),
              const Divider(),
              const SizedBox(height: 60),
              
              // 5. Dynamic Form Section
              if (_currentStep == 0) _buildPersonalInfoStep(),
              if (_currentStep == 1) _buildBusinessInfoStep(),
              if (_currentStep == 2) _buildProductsStep(),
              if (_currentStep == 3) _buildDocumentsStep(),
              if (_currentStep == 4) _buildReviewStep(),
              
              const SizedBox(height: 48),

              // 6. Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavButton(
                    label: 'Previous', 
                    onPressed: _currentStep > 0 ? _previousStep : null,
                    isPrimary: false,
                    icon: Icons.arrow_back,
                  ),
                  _NavButton(
                    label: _currentStep == 4 ? 'Submit Application' : 'Next', 
                    isSubmission: _currentStep == 4,
                    onPressed: _currentStep < 4 
                      ? _nextStep 
                      : () {
                          // Handle final submission here
                          print('Application Submitted');
                        },
                    isPrimary: true,
                    icon: _currentStep == 4 ? Icons.check_circle_outline : Icons.arrow_forward,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
        const _ReadyToStartSellingCard(),
      ],
    );
  }

  Widget _buildProductsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Information',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 32),
        
        Text(
          'Product Categories * (Select all that apply)',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 6,
            children: const [
              _CheckboxItem(label: 'Electronics'),
              _CheckboxItem(label: 'Fashion & Clothing'),
              _CheckboxItem(label: 'Home & Garden'),
              _CheckboxItem(label: 'Beauty & Personal Care'),
              _CheckboxItem(label: 'Sports & Outdoors'),
              _CheckboxItem(label: 'Books & Media'),
              _CheckboxItem(label: 'Toys & Games'),
              _CheckboxItem(label: 'Automotive'),
              _CheckboxItem(label: 'Health & Wellness'),
              _CheckboxItem(label: 'Food & Beverages'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        const Row(
          children: [
            Expanded(
              child: _FormField(
                label: 'Average Order Value (₹)',
                hintText: 'e.g., ₹500-1000 or ₹2500',
                subText: 'Enter amount in rupees or select from suggestions',
              ),
            ),
            SizedBox(width: 32),
            Expanded(
              child: _FormField(
                label: 'Expected Monthly Volume',
                hintText: 'Select volume',
                isDropdown: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        const _FormField(
          label: 'Product Types & Details',
          hintText: 'Describe the types of products you plan to sell...',
          isTextArea: true,
        ),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Documents',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 32),
        
        Text(
          'Business License/Registration *',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        const _FileUploadField(
          hintText: 'Upload your business license or registration document',
        ),
        const SizedBox(height: 24),
        
        const Row(
          children: [
            Expanded(
              child: _FormField(
                label: 'Tax ID/EIN *',
                hintText: 'XX-XXXXXXX',
              ),
            ),
            SizedBox(width: 32),
            Expanded(
              child: _FormField(
                label: 'Bank Account Number *',
                hintText: 'Enter full bank account number',
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFDBEAFE)),
          ),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF1E40AF), height: 1.5),
              children: const [
                TextSpan(text: 'Note: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'All documents will be securely stored and used only for verification purposes. We support PDF, JPG, JPEG, and PNG formats up to 10MB.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review Your Application',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 48),
        
        _BulletReviewSection(
          title: 'Personal Information',
          subtitle: 'sdfsd sd • rohitsengar@gmail.com • sdefsdef',
        ),
        const SizedBox(height: 32),
        
        _BulletReviewSection(
          title: 'Business Information',
          subtitle: 'hotel • Partnership • jaipur, Uttar Pradesh',
        ),
        const SizedBox(height: 32),
        
        _BulletReviewSection(
          title: 'Product Categories',
          subtitle: 'Electronics, Fashion & Clothing',
        ),
        const SizedBox(height: 60),
        
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFF94A3B8)),
              ),
            ),
            const SizedBox(width: 16),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF475569)),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: GoogleFonts.inter(color: const Color(0xFFF01B6B), fontWeight: FontWeight.w500),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: GoogleFonts.inter(color: const Color(0xFFF01B6B), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFF94A3B8)),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'I consent to receive marketing communications and updates about vendor opportunities',
              style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF475569)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 32),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'First Name *', hintText: 'Your first name')),
            SizedBox(width: 32),
            Expanded(child: _FormField(label: 'Last Name *', hintText: 'Your last name')),
          ],
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'Email Address *', hintText: 'rohitsengar@gmail.com')),
            SizedBox(width: 32),
            Expanded(child: _FormField(label: 'Phone Number *', hintText: '+1 (555) 123-4567')),
          ],
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'Password *', hintText: '*********', isPassword: true)),
            SizedBox(width: 32),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Information',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 32),
        const _FormField(label: 'Business Name *', hintText: 'Your business name'),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'Business Type *', hintText: 'Select business type', isDropdown: true)),
            SizedBox(width: 32),
            Expanded(child: _FormField(label: 'Website', hintText: 'https://yourbusiness.com')),
          ],
        ),
        const SizedBox(height: 24),
        const _FormField(label: 'Business Address *', hintText: 'Street address'),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'City *', hintText: 'ROhit@#602')),
            SizedBox(width: 32),
            Expanded(child: _FormField(label: 'State/Province *', hintText: 'State/Province')),
          ],
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _FormField(label: 'Zip Code', hintText: 'Zip Code')),
            SizedBox(width: 32),
            Spacer(),
          ],
        ),
        const SizedBox(height: 24),
        const _FormField(label: 'Business Description *', hintText: 'Tell us about your business...', isTextArea: true),
      ],
    );
  }
}

class _CheckboxItem extends StatelessWidget {
  final String label;
  final bool value;
  const _CheckboxItem({required this.label, this.value = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFCBD5E1)),
            color: value ? const Color(0xFFF01B6B) : Colors.white,
          ),
          child: value ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
        ),
        const SizedBox(width: 12),
        Text(label, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF475569))),
      ],
    );
  }
}

class _ReadyToStartSellingCard extends StatelessWidget {
  const _ReadyToStartSellingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF01B6B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Selling?',
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Join our community of successful vendors and start growing your business today!',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _FeatureItem(title: '2-3 Days', subtitle: 'Application Review'),
              _FeatureItem(title: '24/7', subtitle: 'Vendor Support'),
              _FeatureItem(title: 'No Setup', subtitle: 'Fees to Start'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FileUploadField extends StatelessWidget {
  final String hintText;
  const _FileUploadField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.none),
      ),
      child: CustomPaint(
        painter: _DashedBorderPainter(),
        child: Column(
          children: [
            const Icon(Icons.file_upload_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 16),
            Text(
              hintText,
              style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                'Choose File',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF475569)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double dashWidth = 8;
    final double dashSpace = 4;
    final Radius radius = const Radius.circular(12);

    final RRect rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), radius);
    final Path path = Path()..addRRect(rrect);

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _FeatureItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const _FeatureItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}


class _BulletReviewSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const _BulletReviewSection({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData icon;
  final bool isSubmission;

  const _NavButton({
    required this.label,
    required this.onPressed,
    required this.isPrimary,
    required this.icon,
    this.isSubmission = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPrimary) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          foregroundColor: const Color(0xFF64748B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          disabledForegroundColor: Colors.grey[300],
        ),
      );
    }
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null 
          ? const Color(0xFFCBD5E1) 
          : isSubmission 
            ? const Color(0xFF86D29D) 
            : const Color(0xFFF01B6B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}




class _ToggleButton extends StatelessWidget {
  final String title;
  final bool isActive;
  const _ToggleButton({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF01B6B) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _BenefitCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF01B6B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFF01B6B), size: 28),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final bool isActive;
  final bool isCompleted;
  const _StepItem({
    required this.icon, 
    required this.label, 
    required this.subLabel, 
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCompleted 
                ? const Color(0xFF22C55E) // Green for completed
                : isActive 
                    ? const Color(0xFFF01B6B) // Pink for active
                    : Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon, 
            color: (isCompleted || isActive) ? Colors.white : Colors.grey[400], 
            size: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: isActive ? const Color(0xFFF01B6B) : isCompleted ? const Color(0xFF22C55E) : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subLabel,
          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400]),
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool isDropdown;
  final bool isTextArea;
  final String? subText;
  const _FormField({
    required this.label, 
    required this.hintText, 
    this.isPassword = false,
    this.isDropdown = false,
    this.isTextArea = false,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.replaceAll(' *', ''),
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            if (label.contains('*'))
              const Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 10),
        _buildField(),
        if (subText != null) ...[
          const SizedBox(height: 8),
          Text(
            subText!,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ],
    );
  }

  Widget _buildField() {
    return Container(
      constraints: BoxConstraints(
        minHeight: isTextArea ? 120 : 60,
      ),
      alignment: isTextArea ? Alignment.topLeft : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: isDropdown 
        ? Row(
            children: [
              Expanded(
                child: Text(
                  hintText,
                  style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          )
        : TextField(
            obscureText: isPassword,
            maxLines: isTextArea ? 4 : 1,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16),
            ),
          ),
    );
  }
}


