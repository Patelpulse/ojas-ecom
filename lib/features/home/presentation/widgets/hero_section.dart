import 'package:flutter/material.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
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
    final homeController = HomeController.instance;

    return ListenableBuilder(
      listenable: homeController,
      builder: (context, _) {
        final mainBanners = homeController.mainBanners;
        final sideTop = homeController.sideTopBanner;
        final sideBottom = homeController.sideBottomBanner;

        return CenteredContent(
          horizontalPadding: isMobile ? 16 : 40,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32),
            child: Column(
              children: [
                if (isMobile)
                  Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: mainBanners.isEmpty 
                          ? const HeroMainBanner(
                              title: 'SALE UP TO 50% OFF',
                              subtitle: "They're built to save energy, they help to clean up every door.",
                              imageUrl: 'assets/images/modern_furniture_hero.png',
                            )
                          : HeroMainBanner(
                              title: mainBanners.first.title,
                              subtitle: mainBanners.first.subtitle,
                              imageUrl: mainBanners.first.imageUrl,
                              badgeText: mainBanners.first.tag,
                            ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 180,
                        child: HeroSideBanner(
                          title: sideTop.title,
                          subtitle: sideTop.subtitle,
                          imageUrl: sideTop.imageUrl,
                          badgeText: sideTop.tag.isEmpty ? 'Trending' : sideTop.tag,
                          badgeColor: const Color(0xFFF01B6B),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    height: 600,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CategorySidebar(),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 3,
                          child: mainBanners.isEmpty
                            ? const HeroMainBanner(
                                title: 'SALE UP TO 50% OFF',
                                subtitle: "They're built to save energy, they help to clean up every door. We don't know them well, but we love them.",
                                imageUrl: 'assets/images/modern_furniture_hero.png',
                              )
                            : HeroMainBanner(
                                title: mainBanners.first.title,
                                subtitle: mainBanners.first.subtitle,
                                imageUrl: mainBanners.first.imageUrl,
                                badgeText: mainBanners.first.tag,
                              ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: HeroSideBanner(
                                  title: sideTop.title,
                                  subtitle: sideTop.subtitle,
                                  imageUrl: sideTop.imageUrl,
                                  badgeText: sideTop.tag.isEmpty ? 'Trending' : sideTop.tag,
                                  badgeColor: const Color(0xFFF01B6B),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Expanded(
                                child: HeroSideBanner(
                                  title: sideBottom.title,
                                  subtitle: sideBottom.subtitle,
                                  imageUrl: sideBottom.imageUrl,
                                  badgeText: sideBottom.tag.isEmpty ? 'Premium' : sideBottom.tag,
                                  badgeColor: const Color(0xFF00B4D8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 32),
                const GiftPromoStrip(),
              ],
            ),
          ),
        );
      },
    );
  }
}
