import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/presentation/widgets/category_sidebar.dart';
import 'package:ojas_user/features/home/presentation/widgets/hero_main_banner.dart';
import 'package:ojas_user/features/home/presentation/widgets/hero_side_banner.dart';
import 'package:ojas_user/features/home/presentation/widgets/gift_promo_strip.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32),
        child: Column(
          children: [
            if (isMobile)
              // Mobile View: Just Main Banner and maybe side banners below
              Column(
                children: [
                  const SizedBox(
                    height: 300,
                    child: HeroMainBanner(
                      title: 'SALE UP TO 50% OFF',
                      subtitle: "They're built to save energy, they help to clean up every door.",
                      imageUrl: 'assets/images/modern_furniture_hero.png',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 180,
                    child: HeroSideBanner(
                      title: 'COLORFUL PILLOWS',
                      subtitle: 'Starts at ₹299',
                      imageUrl: 'assets/images/colorful_pillows_promo.png',
                      badgeText: 'Trending',
                      badgeColor: Color(0xFFF01B6B),
                    ),
                  ),
                ],
              )
            else
              // Desktop View: Sidebar + Main + Side Banners
              SizedBox(
                height: 600,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CategorySidebar(),
                    const SizedBox(width: 24),
                    const Expanded(
                      flex: 3,
                      child: HeroMainBanner(
                        title: 'SALE UP TO 50% OFF',
                        subtitle: "They're built to save energy, they help to clean up every door. We don't know them well, but we love them.",
                        imageUrl: 'assets/images/modern_furniture_hero.png',
                      ),
                    ),
                    const SizedBox(width: 24),
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
