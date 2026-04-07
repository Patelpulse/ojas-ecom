import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/constants/app_colors.dart';

class ReturnsRefundsPage extends StatelessWidget {
  const ReturnsRefundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'RETURNS & REFUNDS',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        color: const Color(0xFFF8F9FA),
        child: CenteredContent(
          child: Column(
            children: [
              // 1. Header Section
              _buildHeader(),
              const SizedBox(height: 60),

              // 2. Highlights
              _buildHighlights_4(),
              const SizedBox(height: 80),

              // 3. How to Return
              _buildHowToReturn(),
              const SizedBox(height: 80),

              // 4. Return Policies by Category
              _buildPoliciesByCategory(),
              const SizedBox(height: 80),

              // 5. Refund Options
              _buildRefundOptions(),
              const SizedBox(height: 80),

              // 6. Non-Returnable & Important Notes
              _buildNotesSection(),
              const SizedBox(height: 80),

              // 7. FAQ
              _buildFAQ(),
              const SizedBox(height: 80),

              // 8. Help Banner
              _buildHelpBanner(),
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
          child: const Icon(Icons.refresh, color: Color(0xFFF01B6B), size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'Returns & Refunds',
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
            'We want you to be completely satisfied with your purchase. If you\'re not happy, we\'ll make it right with our hassle-free return policy.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlights_4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _highlightCard('60', 'Days to Return'),
        _highlightCard('Free', 'Return Shipping'),
        _highlightCard('3-5', 'Days for Refund'),
        _highlightCard('100%', 'Money Back'),
      ],
    );
  }

  Widget _highlightCard(String title, String subtitle) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF01B6B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToReturn() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'How to Return an Item',
            style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B)),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stepItem('1', Icons.inventory_2_outlined, 'Initiate Return', 'Log into your account and select the item you want to return'),
              _stepItem('2', Icons.local_shipping_outlined, 'Print Label', 'Download and print the prepaid return shipping label'),
              _stepItem('3', Icons.refresh_outlined, 'Pack & Ship', 'Package the item securely and drop it off at any shipping location'),
              _stepItem('4', Icons.payments_outlined, 'Get Refund', 'Receive your refund within 3-5 business days after we receive the item'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String step, IconData icon, String title, String desc) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Color(0xFFFFEBEE), shape: BoxShape.circle),
                child: Icon(icon, color: const Color(0xFFF01B6B), size: 32),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Color(0xFFF01B6B), shape: BoxShape.circle),
                  child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 12),
          Text(desc, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildPoliciesByCategory() {
    return Column(
      children: [
        Text(
          'Return Policies by Category',
          style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B)),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: [
            _policyCard(Icons.smartphone, 'Electronics', '30 days', '15%', 'Must be in original packaging with all accessories'),
            _policyCard(Icons.checkroom, 'Clothing & Accessories', '60 days', 'None', 'Must have original tags and be unworn'),
            _policyCard(Icons.home, 'Home & Garden', '45 days', '10%', 'Must be unused and in original condition'),
            _policyCard(Icons.menu_book, 'Books & Media', '30 days', 'None', 'Must be in original condition'),
          ],
        ),
      ],
    );
  }

  Widget _policyCard(IconData icon, String category, String window, String fee, String conditions) {
    return Container(
      width: 530,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue[700], size: 24),
              const SizedBox(width: 12),
              Text(category, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 20),
          _policyRow('Return Window:', window),
          _policyRow('Restocking Fee:', fee),
          const SizedBox(height: 16),
          Text('Conditions:', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(conditions, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _policyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
          Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRefundOptions() {
    return Column(
      children: [
        Text(
          'Refund Options',
          style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B)),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _refundOptionCard(Icons.credit_card, 'Original Payment Method', '3-5 business days', 'Refund will be processed back to your original payment method'),
            _refundOptionCard(Icons.inventory_2_outlined, 'Store Credit', 'Instant', 'Receive store credit that can be used for future purchases'),
            _refundOptionCard(Icons.refresh, 'Exchange', '5-7 business days', 'Exchange for a different size, color, or similar item'),
          ],
        ),
      ],
    );
  }

  Widget _refundOptionCard(IconData icon, String title, String time, String desc) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFFFEBEE), shape: BoxShape.circle),
            child: Icon(icon, color: const Color(0xFFF01B6B), size: 28),
          ),
          const SizedBox(height: 24),
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(time, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFFF01B6B))),
          const SizedBox(height: 16),
          Text(desc, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Non-Returnable Items
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 28),
                    const SizedBox(width: 16),
                    Text('Non-Returnable Items', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
                  ],
                ),
                const SizedBox(height: 32),
                Text('For health, safety, and quality reasons, the following items cannot be returned:', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.6)),
                const SizedBox(height: 24),
                _noteItem(Icons.cancel_outlined, 'Personalized or customized items', Colors.red),
                _noteItem(Icons.cancel_outlined, 'Perishable goods (food, flowers, etc.)', Colors.red),
                _noteItem(Icons.cancel_outlined, 'Intimate or sanitary goods', Colors.red),
                _noteItem(Icons.cancel_outlined, 'Hazardous materials', Colors.red),
                _noteItem(Icons.cancel_outlined, 'Digital downloads', Colors.red),
                _noteItem(Icons.cancel_outlined, 'Gift cards', Colors.red),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        // Important Notes
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange, size: 28),
                    const SizedBox(width: 16),
                    Text('Important Notes', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
                  ],
                ),
                const SizedBox(height: 32),
                _noteItemWithDesc(Icons.check_circle_outline, 'Free Return Shipping', 'We provide prepaid return labels for all eligible returns.', Colors.green),
                _noteItemWithDesc(Icons.check_circle_outline, 'Original Packaging', 'Items should be returned in their original packaging when possible.', Colors.green),
                _noteItemWithDesc(Icons.check_circle_outline, 'Inspection Process', 'All returned items are inspected before refunds are processed.', Colors.green),
                _noteItemWithDesc(Icons.access_time, 'Processing Time', 'Refunds are processed within 3-5 business days after we receive your return.', Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _noteItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _noteItemWithDesc(IconData icon, String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Text('Frequently Asked Questions', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1E1B4B))),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _faqItem('Can I return an item without the original packaging?', 'While we prefer items to be returned in original packaging, we understand this isn\'t always possible. Contact our customer service team for assistance.'),
                    _faqItem('What if I received a damaged item?', 'If you received a damaged item, please contact us immediately with photos. We\'ll arrange for a replacement or full refund at no cost to you.'),
                    _faqItem('Can I exchange an item for a different size or color?', 'Yes! You can exchange items for different sizes or colors. Simply initiate a return and place a new order, or contact customer service for assistance.'),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  children: [
                    _faqItem('How long does it take to process a refund?', 'Once we receive your returned item, refunds are typically processed within 3-5 business days. The time for the refund to appear in your account depends on your payment method.'),
                    _faqItem('Do I need to pay for return shipping?', 'No, we provide free return shipping labels for all eligible returns. Simply print the label and drop off your package at any shipping location.'),
                    _faqItem('Can I return items purchased with a discount or coupon?', 'Yes, you can return items purchased with discounts or coupons. The refund will be for the amount you actually paid after the discount was applied.'),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 12),
          Text(answer, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildHelpBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: const Color(0xFFF01B6B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text('Need Help with a Return?', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          Text('Our customer service team is here to help you with any return or refund questions.', style: GoogleFonts.inter(fontSize: 18, color: Colors.white.withOpacity(0.9))),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFF01B6B),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Start a Return', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Contact Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
