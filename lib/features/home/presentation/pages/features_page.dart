import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/features/home/presentation/widgets/featured_header.dart';
import 'package:ojas_user/features/home/presentation/widgets/featured_product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/why_choose_section.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return OjasLayout(
      activeTitle: 'FEATURES',
      child: CenteredContent(
        horizontalPadding: isMobile ? 12 : 20,
        child: ListenableBuilder(
          listenable: HomeController.instance,
          builder: (context, _) {
            // Use backend products if available, fallback to static list
            final backendProducts = HomeController.instance.products;
            final int count = backendProducts.isNotEmpty ? backendProducts.length : _featuredProducts.length;

            return Column(
              children: [
                FeaturedHeader(productCount: count),
                SizedBox(height: isMobile ? 24 : 48),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                    crossAxisSpacing: isMobile ? 16 : 30,
                    mainAxisSpacing: isMobile ? 16 : 30,
                    childAspectRatio: isMobile ? 0.8 : 0.6,
                  ),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    if (backendProducts.isNotEmpty) {
                      final p = backendProducts[index];
                      final id = p['_id']?.toString() ?? p['id']?.toString() ?? '';
                      final imageUrl = (p['images'] != null && (p['images'] as List).isNotEmpty)
                          ? p['images'][0].toString()
                          : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500';
                      final discountPrice = (p['discountPrice'] ?? 0).toDouble();
                      final price = (p['price'] ?? 0).toDouble();
                      final int discountPct = discountPrice > 0 && price > 0
                          ? ((price - discountPrice) / price * 100).round()
                          : 0;
                      return FeaturedProductCard(
                        name: p['name']?.toString() ?? 'Product',
                        imageUrl: imageUrl,
                        price: discountPrice > 0 ? discountPrice : price,
                        oldPrice: discountPrice > 0 ? price : null,
                        discount: discountPct,
                        brand: p['brand']?.toString() ?? 'Brand',
                        category: p['category']?.toString() ?? 'Category',
                        description: p['description']?.toString() ?? '',
                        onAddToCart: () async {
                          final success = await CartController.instance.addToCart(id);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(success ? 'Added to cart!' : 'Failed. Please login.'),
                              backgroundColor: success ? Colors.green : Colors.red,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        },
                      );
                    }
                    // Fallback to static data
                    final product = _featuredProducts[index];
                    return FeaturedProductCard(
                      name: product['name'],
                      imageUrl: product['imageUrl'],
                      price: product['price'],
                      oldPrice: product['oldPrice'],
                      discount: product['discount'],
                      brand: product['brand'],
                      category: product['category'],
                      rating: product['rating'],
                      ratingCount: product['ratingCount'],
                      description: product['description'],
                      badge: product['badge'],
                      badgeColor: product['badgeColor'],
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please login to add items to cart.'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ));
                      },
                    );
                  },
                ),
                SizedBox(height: isMobile ? 40 : 60),
                const WhyChooseSection(),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }
}


final List<Map<String, dynamic>> _featuredProducts = [
  {
    'name': 'Storio Soft Toy Unicorn Plushie – Soft Cuddly Toy for Kids',
    'brand': 'Unknown Brand',
    'category': 'Toys & Games',
    'imageUrl': 'https://images.unsplash.com/photo-1559449182-263d816f3ce5?q=80&w=600&auto=format&fit=crop',
    'price': 499.0,
    'oldPrice': 1599.0,
    'discount': 68,
    'rating': 4.7,
    'ratingCount': 3395,
    'description': 'Adorable and super-soft unicorn plush toy from Storio, perfect for kids\' playtime, gifts, or...',
    'badge': 'Premium',
    'badgeColor': const Color(0xFFE0E7FF),
  },
  {
    'name': 'test product',
    'brand': 'RUDRAM',
    'category': 'Industrial Parts & Tools',
    'imageUrl': 'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?q=80&w=600&auto=format&fit=crop',
    'price': 99.0,
    'oldPrice': 100.0,
    'discount': 1,
    'rating': 4.6,
    'ratingCount': 26759,
    'description': 'ansj,m as djkflas jkf lasj kfl as jkl fask dfl jks ldkf jls dkf jlk sdj fl ksd jf lksd jf lks djlkf s dlf ksa j lkf s dlf ksa j ...',
    'badge': 'New',
    'badgeColor': const Color(0xFFCCFBF1),
  },
  {
    'name': 'Luxury Gold Plated Smartwatch with Premium Leather Strap',
    'brand': 'MAXIMA',
    'category': 'Smart Watches & Tech',
    'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600&auto=format&fit=crop',
    'price': 2499.0,
    'oldPrice': 4999.0,
    'discount': 50,
    'rating': 4.8,
    'ratingCount': 10079,
    'description': 'Elevate your style with this elegant gold-plated smartwatch, combining classic aesthetics with modern tech features...',
    'badge': 'Premium',
    'badgeColor': const Color(0xFFE0E7FF),
  },
  {
    'name': 'Ergonomic Mesh Office Chair with Lumbar Support',
    'brand': 'IKEA',
    'category': 'Furniture',
    'imageUrl': 'https://images.unsplash.com/photo-1592078615290-033ee584e267?q=80&w=600&auto=format&fit=crop',
    'price': 12999.0,
    'oldPrice': 18000.0,
    'discount': 28,
    'rating': 4.5,
    'ratingCount': 500,
    'description': 'Designed for long working hours, this ergonomic chair provides superior back support and comfort...',
    'badge': 'Premium',
    'badgeColor': const Color(0xFFE0E7FF),
  },
  {
    'name': 'Modern Wall Art - Abstract Canvas Painting',
    'brand': 'Storio Home',
    'category': 'Home Decor',
    'imageUrl': 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=600&auto=format&fit=crop',
    'price': 1499.0,
    'oldPrice': 2500.0,
    'discount': 40,
    'rating': 4.3,
    'ratingCount': 120,
    'description': 'Enhance your living space with this beautiful abstract minimalist wall painting...',
    'badge': 'New',
    'badgeColor': const Color(0xFFCCFBF1),
  },
  {
    'name': 'Portable Bluetooth Speaker - Deep Bass & Waterproof',
    'brand': 'BoAt',
    'category': 'Electronics',
    'imageUrl': 'https://images.unsplash.com/photo-1608155613952-30f14d81b0fe?q=80&w=600&auto=format&fit=crop',
    'price': 2999.0,
    'oldPrice': 5999.0,
    'discount': 50,
    'rating': 4.6,
    'ratingCount': 8900,
    'description': 'Compact yet powerful, this waterproof speaker delivers crystal clear sound and powerful bass...',
    'badge': 'Premium',
    'badgeColor': const Color(0xFFE0E7FF),
  },

];

