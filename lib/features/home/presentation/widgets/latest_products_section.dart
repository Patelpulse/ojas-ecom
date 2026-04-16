import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/presentation/widgets/latest_product_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';

class LatestProductsSection extends StatelessWidget {
  const LatestProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final items = [
      {
        'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
        'title': 'Luxury Gold Plated Smartwatch',
        'price': 499.0,
        'oldPrice': 699.0,
        'rating': 3.5,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500',
        'title': 'Black Color Laptop',
        'price': 52999.0,
        'oldPrice': 70000.0,
        'rating': 4.0,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=500',
        'title': 'How to Win Friends and Influence People',
        'price': 396.0,
        'oldPrice': 700.0,
        'rating': 5.0,
        'hasBestSellerBadge': true,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500',
        'title': 'Storio Soft Toy Unicorn Plushie – Soft Cuddly Toy for Kids',
        'price': 358.0,
        'oldPrice': 600.0,
        'rating': 4.5,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500',
        'title': 'Aerofit Spin Bike AF-780 (Yellow/Black) – 12 kg High...',
        'price': 34499.0,
        'oldPrice': 42999.0,
        'rating': 4.0,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
        'title': 'Premium Wireless Noise Cancelling Headphones',
        'price': 99.0,
        'oldPrice': 149.0,
        'rating': 4.5,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500',
        'title': 'Smart Watch with Health Monitor',
        'price': 2999.0,
        'oldPrice': 4500.0,
        'rating': 4.0,
        'hasBestSellerBadge': false,
      },
    ];

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Latest Products',
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            // Horizontal Scrollable List
            SizedBox(
              height: 320,
              child: ListenableBuilder(
                listenable: HomeController.instance,
                builder: (context, _) {
                  final backendProducts = HomeController.instance.products;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: backendProducts.isNotEmpty ? backendProducts.length : items.length,
                    separatorBuilder: (_, _x) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      if (backendProducts.isNotEmpty) {
                        final p = backendProducts[index];
                        final id = p['_id']?.toString() ?? p['id']?.toString() ?? '';
                        final imageUrl = (p['images'] != null && (p['images'] as List).isNotEmpty)
                            ? p['images'][0].toString()
                            : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500';
                        final discountPrice = (p['discountPrice'] ?? 0).toDouble();
                        final price = (p['price'] ?? 0).toDouble();
                        return LatestProductCard(
                          imageUrl: imageUrl,
                          title: p['name']?.toString() ?? 'Product',
                          price: discountPrice > 0 ? discountPrice : price,
                          oldPrice: discountPrice > 0 ? price : price * 1.2,
                          rating: 4.0,
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
                      final item = items[index];
                      return LatestProductCard(
                        imageUrl: item['imageUrl'] as String,
                        title: item['title'] as String,
                        price: item['price'] as double,
                        oldPrice: item['oldPrice'] as double,
                        rating: item['rating'] as double,
                        hasBestSellerBadge: item['hasBestSellerBadge'] as bool,
                        onAddToCart: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Please login to add items to cart.'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
