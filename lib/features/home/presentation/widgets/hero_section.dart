import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/presentation/widgets/category_sidebar.dart';
import 'package:ojas_user/features/home/presentation/widgets/hero_main_banner.dart';
import 'package:ojas_user/features/home/presentation/widgets/hero_side_banner.dart';
import 'package:ojas_user/features/home/presentation/widgets/gift_promo_strip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            // Top Row: Sidebar, Main, Side Banners
            SizedBox(
              height: 600, // Increased height to prevent overflow
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Sidebar (Visible on Desktop)
                  const CategorySidebar(),
                  const SizedBox(width: 24),
                  
                  // 2. Main Banner
                  const Expanded(
                    flex: 3,
                    child: HeroMainBanner(
                      title: 'SALE UP TO 50% OFF',
                      subtitle: "They're built to save energy, they help to clean up every door. We don't know them well, but we love them.",
                      imageUrl: 'assets/images/modern_furniture_hero.png',
                    ),
                  ),
                  const SizedBox(width: 24),
                  
                  // 3. Side Column
                  const Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: HeroSideBanner(
                            title: 'COLORFUL PILLOWS',
                            subtitle: 'Starts at ₹299',
                            imageUrl: 'assets/images/colorful_pillows_promo.png',
                            badgeText: 'Trending',
                            badgeColor: Color(0xFFF01B6B),
                          ),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: HeroSideBanner(
                            title: 'INTERIOR DESIGN',
                            subtitle: '₹499',
                            imageUrl: 'assets/images/interior_design_promo.png',
                            badgeText: 'Premium',
                            badgeColor: Color(0xFF00B4D8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Bottom Strip
            const GiftPromoStrip(),
          ],
        ),
      ),
    );
  }
}
