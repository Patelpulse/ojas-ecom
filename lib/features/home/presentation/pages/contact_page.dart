import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return OjasLayout(
      activeTitle: 'CONTACT US',
      child: Container(
        color: const Color(0xFFF8FAFC),
        padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 60),
        child: CenteredContent(
          horizontalPadding: isMobile ? 12 : 24,
          child: Column(
            children: [
              // 1. Header
              _buildHeader(isMobile),
              SizedBox(height: isMobile ? 32 : 64),

              // 2. Contact Info Cards
              _buildInfoCards(isMobile, isTablet),
              SizedBox(height: isMobile ? 32 : 64),

              // 3. Main Contact Section (Form + Sidebar)
              _buildMainContactSection(isMobile),
              SizedBox(height: isMobile ? 32 : 64),

              // 4. FAQ Section
              _buildFAQSection(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        Text(
          'Contact Us',
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 700,
          child: Text(
            "We're here to help! Get in touch with us through any of the methods below.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              color: const Color(0xFF64748B),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCards(bool isMobile, bool isTablet) {
    if (isMobile) {
      return Column(
        children: [
          _infoCard(Icons.email_outlined, 'Email Us', 'support@ojas.com', 'Send us an email anytime', isMobile),
          const SizedBox(height: 16),
          _infoCard(Icons.phone_outlined, 'Call Us', '+91 9087654321', 'Mon-Fri from 8am to 6pm', isMobile),
          const SizedBox(height: 16),
          _infoCard(Icons.location_on_outlined, 'Visit Us', '123 Business Ave, Suite 100', 'Ghaziabad, Uttar Pradesh', isMobile),
          const SizedBox(height: 16),
          _infoCard(Icons.access_time_outlined, 'Business Hours', 'Mon-Fri: 8am-6pm', 'Weekend: 10am-4pm', isMobile),
        ],
      );
    }
    
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _infoCard(Icons.email_outlined, 'Email Us', 'support@ojas.com', 'Send us an email anytime', isMobile),
        _infoCard(Icons.phone_outlined, 'Call Us', '+91 9087654321', 'Mon-Fri from 8am to 6pm', isMobile),
        _infoCard(Icons.location_on_outlined, 'Visit Us', '123 Business Ave, Suite 100', 'Ghaziabad, Uttar Pradesh', isMobile),
        _infoCard(Icons.access_time_outlined, 'Business Hours', 'Mon-Fri: 8am-6pm', 'Weekend: 10am-4pm', isMobile),
      ],
    );
  }

  Widget _infoCard(IconData icon, String title, String value, String subtitle, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 280,
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFFFFF1F2), shape: BoxShape.circle),
            child: Icon(icon, color: const Color(0xFFF01B6B), size: 24),
          ),
          const SizedBox(height: 20),
          Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFFF01B6B))),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _buildMainContactSection(bool isMobile) {
    final List<Widget> children = [
      // LEFT: Contact Form
      Expanded(
        flex: isMobile ? 0 : 2,
        child: Container(
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Send us a Message', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 40),
              if (isMobile) ...[
                _buildField('Full Name *', 'Your full name'),
                const SizedBox(height: 24),
                _buildField('Email Address *', 'your@email.com'),
              ] else
                Row(
                  children: [
                    Expanded(child: _buildField('Full Name *', 'Your full name')),
                    const SizedBox(width: 24),
                    Expanded(child: _buildField('Email Address *', 'your@email.com')),
                  ],
                ),
              const SizedBox(height: 24),
              _buildField('Subject *', 'Select a subject', isDropdown: true),
              const SizedBox(height: 24),
              _buildField('Message *', 'Tell us how we can help you...', maxLines: 5),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: Text('Send Message', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF01B6B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (isMobile) const SizedBox(height: 48) else const SizedBox(width: 48),
      // RIGHT: Sidebar & Map
      Expanded(
        flex: isMobile ? 0 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Other Ways to Reach Us', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 24),
            _reachOutItem(Icons.chat_bubble_outline, 'Live Chat', 'Chat with our support team in real-time', 'Start Chat →'),
            const SizedBox(height: 16),
            _reachOutItem(Icons.headset_mic_outlined, 'Phone Support', 'Speak directly with our customer service', 'Call Now →'),
            const SizedBox(height: 16),
            _reachOutItem(Icons.email_outlined, 'Email Support', 'Send us a detailed message', 'Send Email →'),
            const SizedBox(height: 40),
            Text('Find Us', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF64748B), size: 32),
                    const SizedBox(height: 12),
                    Text('Interactive Map', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF475569))),
                    Text('123 Business Ave, Suite 100\nGhaziabad, Uttar Pradesh', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    if (isMobile) {
      return Column(children: children);
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  Widget _buildField(String label, String hint, {int maxLines = 1, bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: isDropdown
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hint, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14)),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
                  ],
                )
              : TextField(
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _reachOutItem(IconData icon, String title, String desc, String action) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFFF01B6B), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(desc, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                const SizedBox(height: 8),
                Text(action, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFF01B6B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
      ),
      child: Column(
        children: [
          Text('Frequently Asked Questions', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)), textAlign: TextAlign.center),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: [
                _faqItem('What are your response times?', 'We typically respond to emails within 24 hours.'),
                const SizedBox(height: 32),
                _faqItem('Do you offer international support?', 'Yes, we provide support globally.'),
                const SizedBox(height: 32),
                _faqItem('Can I track my order status?', 'Absolutely! You can track your order in the dashboard.'),
                const SizedBox(height: 32),
                _faqItem('How do I return a product?', 'Visit our Returns page for instructions.'),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _faqItem('What are your response times?', 'We typically respond to emails within 24 hours.'),
                      const SizedBox(height: 32),
                      _faqItem('Do you offer international support?', 'Yes, we provide support globally.'),
                    ],
                  ),
                ),
                const SizedBox(width: 64),
                Expanded(
                  child: Column(
                    children: [
                      _faqItem('Can I track my order status?', 'Absolutely! You can track your order in the dashboard.'),
                      const SizedBox(height: 32),
                      _faqItem('How do I return a product?', 'Visit our Returns page for instructions.'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B))),
        const SizedBox(height: 12),
        Text(answer, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF64748B), height: 1.6)),
      ],
    );
  }
}
