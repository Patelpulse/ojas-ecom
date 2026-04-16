import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/service_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/category_filter.dart';
import 'package:ojas_user/features/home/presentation/widgets/trending_promo_banner.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';

class TrendingItemsSection extends StatelessWidget {
  const TrendingItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductModel.dummyProducts;
    final bool isMobile = Responsive.isMobile(context);

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Column(
        children: [
          SizedBox(height: isMobile ? 32 : 60),
          // 1. Header
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CategoryFilter(
                    categories: ['All', 'Pet Supplies', 'Jewelry', 'Parts', 'Books', 'Toys'],
                    selectedCategory: 'All',
                  ),
                ),
              ],
            )
          else
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
          SizedBox(height: isMobile ? 24 : 40),
          
          // 2. Service Grid & Banner
          if (isMobile)
            Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ServiceCard(
                      title: 'FREE DELIVERY',
                      subtitle: 'From \$89.00',
                      iconUrl: 'https://cdn-icons-png.flaticon.com/512/709/709790.png',
                    ),
                    ServiceCard(
                      title: 'ORDER PROTECTION',
                      subtitle: '120 Day',
                      iconUrl: 'https://cdn-icons-png.flaticon.com/512/1161/1161388.png',
                    ),
                    ServiceCard(
                      title: 'PAYMENT SECURITY',
                      subtitle: 'SSL Secure',
                      iconUrl: 'https://cdn-icons-png.flaticon.com/512/1069/1069159.png',
                    ),
                    ServiceCard(
                      title: '24/7 SUPPORT',
                      subtitle: 'Dedicated',
                      iconUrl: 'https://cdn-icons-png.flaticon.com/512/2838/2838634.png',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 250, child: TrendingPromoBanner()),
              ],
            )
          else
            SizedBox(
              height: 380,
              child: Row(
                children: [
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
                  const Expanded(
                    flex: 2,
                    child: TrendingPromoBanner(),
                  ),
                ],
              ),
            ),
          
          SizedBox(height: isMobile ? 32 : 48),
          
          // 3. Trending Product Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 5,
              mainAxisSpacing: isMobile ? 12 : 24,
              crossAxisSpacing: isMobile ? 12 : 24,
              childAspectRatio: isMobile ? 0.65 : 0.62,
            ),
            itemBuilder: (context, index) {
              final product = products[index % products.length];
              return ProductCard(
                product: product,
                onAddToCart: () async {
                  final success = await CartController.instance.addToCart(product.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(success ? '${product.name} added to cart!' : 'Failed to add. Please login.'),
                      backgroundColor: success ? Colors.green : Colors.red,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ));
                  }
                },
              );
            },
          ),
          SizedBox(height: isMobile ? 32 : 60),
        ],
      ),
    );
  }
}
