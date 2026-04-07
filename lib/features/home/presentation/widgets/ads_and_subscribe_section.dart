import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class AdsAndSubscribeSection extends StatelessWidget {
  const AdsAndSubscribeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bgPrimaryLight,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
      child: CenteredContent(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 850;
                
                if (isDesktop) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(child: _OfferCard()),
                        SizedBox(width: 24),
                        Expanded(child: _SubscribeCard()),
                      ],
                    ),
                  );
                } else {
                  return const Column(
                    children: [
                      _OfferCard(),
                      SizedBox(height: 24),
                      _SubscribeCard(),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 48),
            // Bottom guarantees row
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 32,
              runSpacing: 16,
              children: [
                _buildGuarantee(Icons.check_circle_outline, '10,000+ Happy Customers'),
                _buildGuarantee(Icons.check_circle_outline, 'No Spam Guarantee'),
                _buildGuarantee(Icons.check_circle_outline, 'Unsubscribe Anytime'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuarantee(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade400),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.grey.shade500,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE91E63).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.card_giftcard, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'LIMITED TIME',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          RichText(
            text: TextSpan(
              style: GoogleFonts.outfit(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Get '),
                TextSpan(
                  text: '50% OFF\n',
                  style: TextStyle(color: Colors.yellow.shade400),
                ),
                const TextSpan(text: 'Your First Order'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'Discover amazing deals on premium products. Limited time offer for new customers only!',
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFE91E63),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.flash_on, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Claim Offer',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white.withOpacity(0.8), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Valid until Dec 31, 2024',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscribeCard extends StatelessWidget {
  const _SubscribeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)], // Violet/Indigo
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.mail_outline, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            'Stay in the Loop',
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Subscribe to our newsletter and be the first to know about exclusive\ndeals, new arrivals, and special promotions.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          
          // Input field
          Container(
            height: 54,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.mail_outline, color: Colors.grey.shade400, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subscribe Now',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Divider
          Divider(color: Colors.grey.shade100, thickness: 1),
          const SizedBox(height: 16),
          
          // Perks
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What you\'ll get:',
              style: GoogleFonts.inter(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPerk(Colors.red.shade400, 'Exclusive discounts'),
                    const SizedBox(height: 12),
                    _buildPerk(Colors.green.shade400, 'New product alerts'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPerk(Colors.blue.shade400, 'Early access to sales'),
                    const SizedBox(height: 12),
                    _buildPerk(Colors.purple.shade400, 'Weekly style tips'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerk(Color dotColor, String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
