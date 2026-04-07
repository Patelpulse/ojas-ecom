import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/features/home/presentation/widgets/featured_header.dart';
import 'package:ojas_user/features/home/presentation/widgets/featured_product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/why_choose_section.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';


class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'FEATURES',
      child: CenteredContent(
        horizontalPadding: 20,
        child: Column(
          children: [
            const FeaturedHeader(productCount: 6),
            const SizedBox(height: 48),
            
            // Product Grid
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 3;
                if (constraints.maxWidth < 700) crossAxisCount = 1;
                else if (constraints.maxWidth < 1100) crossAxisCount = 2;
                
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.6, // Adjusted to prevent bottom overflow
                  ),
                  itemCount: _featuredProducts.length,
                  itemBuilder: (context, index) {
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
                    );
                  },
                );
              },
            ),
            
            const SizedBox(height: 60),

            // 5. Why Choose Section
            const WhyChooseSection(),

            const SizedBox(height: 100), // Extra space at bottom
          ],
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

