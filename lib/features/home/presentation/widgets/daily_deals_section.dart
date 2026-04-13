import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/daily_deal_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class DailyDealsSection extends StatelessWidget {
  const DailyDealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyDeals = ProductModel.getDailyDeals();
    final bool isMobile = Responsive.isMobile(context);

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Header with Navigation
          Row(
            children: [
              Text(
                'Daily Deals',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _navButton(Icons.chevron_left),
              const SizedBox(width: 8),
              _navButton(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 32),
          
          // Cards: Row on Desktop, Column on Mobile
          if (isMobile)
            Column(
              children: [
                DailyDealCard(product: dailyDeals[0]),
                const SizedBox(height: 16),
                DailyDealCard(product: dailyDeals[1]),
              ],
            )
          else
            Row(
              children: [
                Expanded(child: DailyDealCard(product: dailyDeals[0])),
                const SizedBox(width: 24),
                Expanded(child: DailyDealCard(product: dailyDeals[1])),
              ],
            ),
          
          const SizedBox(height: 32),
          // Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pageDot(false),
              const SizedBox(width: 8),
              _pageDot(true),
              const SizedBox(width: 8),
              _pageDot(false),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Icon(icon, size: 20, color: Colors.grey),
    );
  }

  Widget _pageDot(bool active) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF01B6B) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
