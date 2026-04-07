import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/features/home/presentation/widgets/just_for_you_card.dart';
import 'package:google_fonts/google_fonts.dart';

class JustForYouSection extends StatelessWidget {
  const JustForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Just For You
    final items = [
      {
        'imageUrl': 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500', // Unicorn Plushie (approx)
        'brand': 'Unknown Brand',
        'title': 'Storio Soft Toy Unicorn Plushie - Soft Cuddly Toy',
        'price': 358.0,
        'oldPrice': 600.0,
        'discount': 68,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500', // Spin Bike
        'brand': 'Unknown Brand',
        'title': 'Aerofit Spin Bike AF-780 (Yellow/Black) - 12 kg...',
        'price': 34499.0,
        'oldPrice': 42999.0,
        'discount': 25,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500', // Watch
        'brand': 'RUDRAM',
        'title': 'Luxury Gold Plated Smartwatch',
        'price': 499.99,
        'oldPrice': 699.99,
        'discount': 40,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', // Laptop
        'brand': 'Yogesh',
        'title': 'Black Color Laptop',
        'price': 52999.0,
        'oldPrice': 70000.0,
        'discount': 32,
        'hasBestSellerBadge': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=500', // Book
        'brand': 'Unknown Brand',
        'title': 'How to Win Friends and Influence People',
        'price': 396.0,
        'oldPrice': 700.0,
        'discount': 77,
        'hasBestSellerBadge': true,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', // Headphones
        'brand': 'RUDRAM',
        'title': 'Premium Wireless Headphones',
        'price': 99.0,
        'oldPrice': 100.0,
        'discount': 1,
        'hasBestSellerBadge': false,
      },
    ];

    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Just For You',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF01B6B),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return JustForYouCard(
                  imageUrl: item['imageUrl'] as String,
                  brand: item['brand'] as String,
                  title: item['title'] as String,
                  price: item['price'] as double,
                  oldPrice: item['oldPrice'] as double,
                  discount: item['discount'] as int,
                  hasBestSellerBadge: item['hasBestSellerBadge'] as bool,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
