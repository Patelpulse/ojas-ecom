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
          if (dailyDeals.isEmpty)
             const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('Check back later for daily deals!', style: TextStyle(color: Colors.grey))))
          else if (isMobile)
            Column(
              children: dailyDeals.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DailyDealCard(product: p),
              )).toList(),
            )
          else
            Row(
              children: [
                for (var i = 0; i < dailyDeals.length; i++) ...[
                  Expanded(child: DailyDealCard(product: dailyDeals[i])),
                  if (i < dailyDeals.length - 1) const SizedBox(width: 24),
                ],
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
