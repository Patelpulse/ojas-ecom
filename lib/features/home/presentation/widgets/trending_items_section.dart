import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/service_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/category_filter.dart';
import 'package:ojas_user/features/home/presentation/widgets/trending_promo_banner.dart';

class TrendingItemsSection extends StatelessWidget {
  const TrendingItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductModel.dummyProducts;

    return CenteredContent(
      child: Column(
        children: [
          const SizedBox(height: 60),
          // 1. Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'TRENDING ITEMS',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5),
                ),
              ),
              const Spacer(),
              const CategoryFilter(
                categories: ['All', 'Pet Supplies', 'Jewelry & Accessories', 'Industrial Parts & Tools', 'Books & Stationery', 'Toys & Games'],
                selectedCategory: 'All',
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // 2. Service Grid & Banner
          SizedBox(
            height: 380,
            child: Row(
              children: [
                // Left: 2x2 Service Grid
                Expanded(
                  flex: 3,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.4,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      ServiceCard(
                        title: 'FREE DELIVERY',
                        subtitle: 'From \$89.00',
                        iconUrl: 'https://cdn-icons-png.flaticon.com/512/709/709790.png',
                      ),
                      ServiceCard(
                        title: 'ORDER PROTECTION',
                        subtitle: 'Refund/Resent 120 Day',
                        iconUrl: 'https://cdn-icons-png.flaticon.com/512/1161/1161388.png',
                      ),
                      ServiceCard(
                        title: 'PAYMENT SECURITY',
                        subtitle: 'SSL Secure Payment',
                        iconUrl: 'https://cdn-icons-png.flaticon.com/512/1069/1069159.png',
                      ),
                      ServiceCard(
                        title: '24/7 SUPPORT',
                        subtitle: 'Dedicated Support',
                        iconUrl: 'https://cdn-icons-png.flaticon.com/512/2838/2838634.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Right: Promo Banner
                const Expanded(
                  flex: 2,
                  child: TrendingPromoBanner(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 48),
          
          // 3. Trending Product Grid (5-column)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5, // Displaying 5 as per reference
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index % products.length]);
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
