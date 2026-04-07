import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'TERMS & CONDITIONS',
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
              _buildSectionCard('Introduction', 'Welcome to Ojas! These Terms and Conditions ("Terms", "Terms and Conditions") govern your relationship with Ojas website (the "Service") operated by Ojas ("us", "we", or "our").\n\nYour access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.', icon: Icons.info_outline),
              const SizedBox(height: 24),

              // 4. Detailed Sections
              _buildSectionCard('Acceptance of Terms', 'By accessing and using Ojas\'s website and services, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.', icon: Icons.check_circle_outline),
              const SizedBox(height: 24),
              _buildSectionCard('Definitions', 'In these Terms and Conditions, \'Company\' refers to Ojas, \'Service\' refers to our website and related services, \'User\' refers to anyone who accesses or uses our Service, and \'Content\' refers to all information, data, text, software, music, sound, photographs, graphics, video, messages, or other materials.', icon: Icons.description_outlined),
              const SizedBox(height: 24),
              _buildSectionCard('User Accounts', 'To access certain features of our Service, you may be required to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.', icon: Icons.person_outline),
              const SizedBox(height: 24),
              _buildSectionCard('Acceptable Use Policy', 'You agree to use our Service only for lawful purposes and in accordance with these Terms. You may not use our Service to transmit, distribute, store or destroy material that could constitute or encourage conduct that would be considered a criminal offense, give rise to civil liability, or otherwise violate any law or regulation.', icon: Icons.security_outlined),
              const SizedBox(height: 24),
              _buildSectionCard('Intellectual Property Rights', 'The Service and its original content, features, and functionality are and will remain the exclusive property of Ojas and its licensors. The Service is protected by copyright, trademark, and other laws. Our trademarks and trade dress may not be used in connection with any product or service without our prior written consent.', icon: Icons.gavel_outlined),
              const SizedBox(height: 24),
              _buildSectionCard('Privacy Policy', 'Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the Service, to understand our practices regarding the collection, use, and disclosure of your personal information.', icon: Icons.lock_outline),
              const SizedBox(height: 48),

              // 5. Prohibited Activities
              _buildProhibitedActivities(),
              const SizedBox(height: 48),

              // 6. Rights & Responsibilities
              _buildRightsAndResponsibilities(),
              const SizedBox(height: 48),

              // 7. Additional Terms
              _buildAdditionalTerms(),
              const SizedBox(height: 48),

              // 8. Contact Info
              _buildContactInfo(),
              const SizedBox(height: 60),

              // 9. Footer Banner
              _buildAgreementAcknowledgment(context),
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
          child: const Icon(Icons.description, color: Color(0xFFF01B6B), size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'Terms & Conditions',
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
            'Please read these terms and conditions carefully before using our Service. These terms govern your use of Ojas\'s website and services.',
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
              _tocItem(Icons.check_circle_outline, 'Acceptance of Terms'),
              _tocItem(Icons.description_outlined, 'Definitions'),
              _tocItem(Icons.person_outline, 'User Accounts', isSelected: true),
              _tocItem(Icons.security_outlined, 'Acceptable Use Policy'),
              _tocItem(Icons.gavel_outlined, 'Intellectual Property Rights'),
              _tocItem(Icons.lock_outline, 'Privacy Policy'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tocItem(IconData icon, String text, {bool isSelected = false}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFEBEE) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFF01B6B)),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFFF01B6B), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, String content, {IconData? icon}) {
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
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: const Color(0xFFF01B6B), size: 24),
                ),
                const SizedBox(width: 20),
              ],
              Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
            ],
          ),
          const SizedBox(height: 24),
          Text(content, style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700], height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildProhibitedActivities() {
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
                child: const Icon(Icons.cancel_outlined, color: Color(0xFFF01B6B), size: 24),
              ),
              const SizedBox(width: 20),
              Text('Prohibited Activities', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
            ],
          ),
          const SizedBox(height: 24),
          Text('You may not access or use the Service for any purpose other than that for which we make the Service available. Prohibited activities include, but are not limited to:', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700], height: 1.6)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 40,
            runSpacing: 16,
            children: [
              _prohibitedItem('Violating any applicable laws or regulations'),
              _prohibitedItem('Infringing on intellectual property rights'),
              _prohibitedItem('Transmitting harmful or malicious code'),
              _prohibitedItem('Attempting to gain unauthorized access to our systems'),
              _prohibitedItem('Interfering with the proper functioning of the Service'),
              _prohibitedItem('Engaging in fraudulent activities'),
              _prohibitedItem('Harassing or threatening other users'),
              _prohibitedItem('Posting false or misleading information'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _prohibitedItem(String text) {
    return SizedBox(
      width: 500,
      child: Row(
        children: [
          const Icon(Icons.cancel_outlined, color: Colors.red, size: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]))),
        ],
      ),
    );
  }

  Widget _buildRightsAndResponsibilities() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _columnCard(
            'Your Rights',
            'As a user of our Service, you have the following rights:',
            Icons.check_circle_outline,
            Colors.green,
            [
              'Access and use our Service in accordance with these Terms',
              'Create an account and maintain your profile',
              'Purchase products and services offered on our platform',
              'Receive customer support and assistance',
              'Request deletion of your personal data',
              'Opt-out of marketing communications',
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _columnCard(
            'Your Responsibilities',
            'As a user of our Service, you are responsible for:',
            Icons.person_search_outlined,
            Colors.blue,
            [
              'Provide accurate and complete information',
              'Maintain the security of your account credentials',
              'Comply with all applicable laws and regulations',
              'Respect the rights of other users and third parties',
              'Use the Service only for its intended purposes',
              'Report any violations or security issues',
            ],
          ),
        ),
      ],
    );
  }

  Widget _columnCard(String title, String subtitle, IconData icon, Color color, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 20),
              Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
            ],
          ),
          const SizedBox(height: 24),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 32),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(title == 'Your Rights' ? Icons.check_circle_outline : Icons.info_outline, color: color.withOpacity(0.8), size: 18),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAdditionalTerms() {
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
          Text('Additional Important Terms', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _subSection('Limitation of Liability', 'In no event shall Ojas, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.'),
                    const SizedBox(height: 32),
                    _subSection('Disclaimer', 'The information on this website is provided on an "as is" basis. To the fullest extent permitted by law, this Company excludes all representations, warranties, conditions and terms.'),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _subSection('Governing Law', 'These Terms shall be interpreted and governed by the laws of the State of New York, without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights.'),
                    const SizedBox(height: 32),
                    _subSection('Changes to Terms', 'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will try to provide at least 30 days notice prior to any new terms taking effect.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _subSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 12),
        Text(content, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.6)),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        Text('Contact Information', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
        const SizedBox(height: 16),
        Text('If you have any questions about these Terms and Conditions, please contact us:', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _contactCard(Icons.email_outlined, 'Email', 'legal@ojas.com'),
            _contactCard(Icons.language_outlined, 'Website', 'www.ojas.com'),
            _contactCard(Icons.location_on_outlined, 'Address', '123 Business Ave, Suite 100\nNew York, NY 10001'),
          ],
        ),
      ],
    );
  }

  Widget _contactCard(IconData icon, String title, String value) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFF01B6B), size: 32),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 12),
          Text(value, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildAgreementAcknowledgment(BuildContext context) {
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
            'Agreement Acknowledgment',
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 800,
            child: Text(
              'By using our Service, you acknowledge that you have read and understood these Terms and Conditions and agree to be bound by them.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _ackButton('Privacy Policy', onPressed: () {}),
              _ackButton('Returns & Refunds', onPressed: () => Navigator.pushNamed(context, '/returns')),
              _ackButton('Contact Us', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ackButton(String label, {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.15),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
