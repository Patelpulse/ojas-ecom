import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'PRIVACY POLICY',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        color: const Color(0xFFF8F9FA),
        child: CenteredContent(
          child: Column(
            children: [
              // 1. Header
              _buildHeader(),
              const SizedBox(height: 60),

              // 2. Table of Contents
              _buildTableOfContents(),
              const SizedBox(height: 48),

              // 3. Introduction
              _buildSectionCard(
                'Introduction',
                'At Ojas, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our website, mobile application, and related services.\n\nBy using our services, you agree to the collection and use of information in accordance with this policy. If you do not agree with our policies and practices, please do not use our services.',
              ),
              const SizedBox(height: 24),

              // 4. Information We Collect
              _buildDetailedSectionCard(
                'Information We Collect',
                icon: Icons.storage_outlined,
                subsections: [
                  _Subsection('Personal Information', 'We collect information you provide directly to us, such as when you create an account, make a purchase, subscribe to our newsletter, or contact us for support. This may include your name, email address, phone number, shipping address, and payment information.'),
                  _Subsection('Automatically Collected Information', 'We automatically collect certain information about your device and how you interact with our services, including IP address, browser type, operating system, referring URLs, pages viewed, and the dates/times of visits.'),
                  _Subsection('Cookies and Tracking Technologies', 'We use cookies, web beacons, and similar tracking technologies to collect information about your browsing activities and preferences to provide personalized experiences and improve our services.'),
                ],
              ),
              const SizedBox(height: 24),

              // 5. How We Use Your Information
              _buildDetailedSectionCard(
                'How We Use Your Information',
                icon: Icons.remove_red_eye_outlined,
                subsections: [
                  _Subsection('Service Provision', 'We use your information to provide, maintain, and improve our services, process transactions, send order confirmations, and provide customer support.'),
                  _Subsection('Communication', 'We may use your information to send you promotional materials, newsletters, and other communications that may be of interest to you. You can opt out of these communications at any time.'),
                  _Subsection('Analytics and Improvements', 'We analyze usage patterns and feedback to understand how our services are used and to improve functionality, user experience, and develop new features.'),
                ],
              ),
              const SizedBox(height: 24),

              // 6. Information Sharing and Disclosure
              _buildDetailedSectionCard(
                'Information Sharing and Disclosure',
                icon: Icons.group_outlined,
                subsections: [
                  _Subsection('Service Providers', 'We may share your information with third-party service providers who perform services on our behalf, such as payment processing, data analysis, email delivery, hosting services, and customer service.'),
                  _Subsection('Business Transfers', 'In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of that transaction.'),
                  _Subsection('Legal Requirements', 'We may disclose your information if required to do so by law or if we believe that such action is necessary to comply with legal processes, protect our rights, or ensure the safety of our users.'),
                ],
              ),
              const SizedBox(height: 24),

              // 7. Data Security
              _buildDetailedSectionCard(
                'Data Security',
                icon: Icons.lock_outline,
                subsections: [
                  _Subsection('Security Measures', 'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.'),
                  _Subsection('Encryption', 'We use industry-standard encryption protocols to protect sensitive information during transmission and storage.'),
                  _Subsection('Access Controls', 'Access to personal information is restricted to employees and contractors who need it to perform their job functions and are bound by confidentiality obligations.'),
                ],
              ),
              const SizedBox(height: 24),

              // 8. Your Rights and Choices
              _buildDetailedSectionCard(
                'Your Rights and Choices',
                icon: Icons.security_outlined,
                subsections: [
                  _Subsection('Account Information', 'You can update, correct, or delete your account information at any time by logging into your account settings or contacting us directly.'),
                  _Subsection('Marketing Communications', 'You can opt out of receiving promotional emails by following the unsubscribe instructions in those emails or by updating your preferences in your account settings.'),
                  _Subsection('Data Portability', 'You have the right to request a copy of your personal information in a structured, commonly used format.'),
                  _Subsection('Data Deletion', 'You can request deletion of your personal information, subject to certain legal and business requirements.'),
                ],
              ),
              const SizedBox(height: 48),

              // 9. Contact Us About Privacy
              _buildPrivacyContact(),
              const SizedBox(height: 48),

              // 10. Related Information
              _buildRelatedInformation(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.security, color: Color(0xFFF01B6B), size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'Privacy Policy',
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1B4B),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 700,
          child: Text(
            'Your privacy is important to us. This policy explains how we collect, use, and protect your information.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 18, color: Colors.grey[600], height: 1.6),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Last updated: November 6, 2024',
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildTableOfContents() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table of Contents', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
          const SizedBox(height: 32),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            children: [
              _tocItem(Icons.storage_outlined, 'Information We Collect'),
              _tocItem(Icons.remove_red_eye_outlined, 'How We Use Your Information'),
              _tocItem(Icons.group_outlined, 'Information Sharing and Disclosure'),
              _tocItem(Icons.lock_outline, 'Data Security'),
              _tocItem(Icons.security_outlined, 'Your Rights and Choices'),
              _tocItem(Icons.language_outlined, 'International Data Transfers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tocItem(IconData icon, String text) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFF01B6B)),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFFF01B6B))),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
          const SizedBox(height: 24),
          Text(content, style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700], height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildDetailedSectionCard(String title, {required IconData icon, required List<_Subsection> subsections}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: const Color(0xFFF01B6B), size: 24),
              ),
              const SizedBox(width: 20),
              Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
            ],
          ),
          const SizedBox(height: 32),
          ...subsections.map((sub) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sub.title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 12),
                    Text(sub.content, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.6)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPrivacyContact() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us About Privacy',
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B)),
          ),
          const SizedBox(height: 16),
          Text(
            'If you have any questions about this Privacy Policy or our privacy practices, please contact us using the information below:',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.6),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _contactSubCard(Icons.email_outlined, 'Email', 'privacy@ojas.com'),
              _contactSubCard(Icons.phone_outlined, 'Phone', '+1 (555) 123-4567'),
              _contactSubCard(Icons.location_on_outlined, 'Address', '123 Business Ave, Suite 100\nNew York, NY 10001'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactSubCard(IconData icon, String title, String value) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFF01B6B), size: 24),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(value, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildRelatedInformation(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF01B6B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Related Information',
            style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Learn more about our policies and how we protect you',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 18, color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _relatedButton(Icons.email_outlined, 'Contact Us', onPressed: () {}),
              _relatedButton(Icons.description_outlined, 'Terms & Conditions', onPressed: () => Navigator.pushNamed(context, '/terms')),
              _relatedButton(Icons.refresh_outlined, 'Returns & Refunds', onPressed: () => Navigator.pushNamed(context, '/returns')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _relatedButton(IconData icon, String label, {required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.15),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}

class _Subsection {
  final String title;
  final String content;
  _Subsection(this.title, this.content);
}
