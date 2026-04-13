import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/presentation/widgets/category_promo_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/weekend_deals_slider.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class PromoGridSection extends StatelessWidget {
  const PromoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 40.0),
        child: isMobile
            ? Column(
                children: [
                  const SizedBox(
                    height: 300,
                    child: WeekendDealsSlider(),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: const [
                      CategoryPromoCard(
                        backgroundColor: Colors.blue,
                        badgeText: 'BEST SALE',
                        badgeColor: Colors.blue,
                        badgeIcon: Icons.bolt,
                        title: 'Beauty',
                        subtitle: 'Personal Care',
                        trailingIcon: Icons.laptop_mac_outlined,
                      ),
                      CategoryPromoCard(
                        backgroundColor: Colors.orange,
                        badgeText: 'NEW',
                        badgeColor: Colors.orange,
                        badgeIcon: Icons.star_border,
                        title: 'Toys',
                        subtitle: 'Games',
                        trailingIcon: Icons.extension_outlined,
                      ),
                      CategoryPromoCard(
                        backgroundColor: Colors.green,
                        badgeText: '15% OFF',
                        badgeColor: Colors.green,
                        badgeIcon: Icons.local_offer_outlined,
                        title: 'Gadgets',
                        subtitle: 'Latest',
                        trailingIcon: Icons.watch_outlined,
                      ),
                      CategoryPromoCard(
                        backgroundColor: Colors.deepPurple,
                        badgeText: 'FREE SHIP',
                        badgeColor: Colors.deepPurple,
                        badgeIcon: Icons.local_shipping_outlined,
                        title: 'Books',
                        subtitle: 'Stationery',
                        trailingIcon: Icons.headphones_outlined,
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox(
                height: 480,
                child: Row(
                  children: [
                    // Left: 2x2 Grid
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Expanded(
                                  child: CategoryPromoCard(
                                    backgroundColor: Colors.blue,
                                    badgeText: 'BEST SALE',
                                    badgeColor: Colors.blue,
                                    badgeIcon: Icons.bolt,
                                    title: 'Beauty & Personal Care',
                                    subtitle: 'Beauty & Personal Care',
                                    trailingIcon: Icons.laptop_mac_outlined,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CategoryPromoCard(
                                    backgroundColor: Colors.orange,
                                    badgeText: 'NEW ARRIVAL',
                                    badgeColor: Colors.orange,
                                    badgeIcon: Icons.star_border,
                                    title: 'Toys & Games',
                                    subtitle: 'Toys & Games',
                                    trailingIcon: Icons.extension_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Row(
                              children: const [
                                Expanded(
                                  child: CategoryPromoCard(
                                    backgroundColor: Colors.green,
                                    badgeText: 'OFF 15%',
                                    badgeColor: Colors.green,
                                    badgeIcon: Icons.local_offer_outlined,
                                    title: 'Gadgets',
                                    subtitle: 'Gadgets',
                                    trailingIcon: Icons.watch_outlined,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CategoryPromoCard(
                                    backgroundColor: Colors.deepPurple,
                                    badgeText: 'FREE SHIPPING',
                                    badgeColor: Colors.deepPurple,
                                    badgeIcon: Icons.local_shipping_outlined,
                                    title: 'Books & Stationery',
                                    subtitle: 'Books & Stationery',
                                    trailingIcon: Icons.headphones_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right: Weekend Deals Slider
                    const Expanded(
                      flex: 5,
                      child: WeekendDealsSlider(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
