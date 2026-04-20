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

    return CenteredContent(
      horizontalPadding: isMobile ? 16 : 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Products',
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 20 : 24,
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
            
            ListenableBuilder(
              listenable: HomeController.instance,
              builder: (context, _) {
                final backendProducts = HomeController.instance.products;

                if (backendProducts.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.new_releases_outlined, size: 40, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          'Stay tuned! New products arriving soon.',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: backendProducts.length > 5 ? 5 : backendProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 5,
                    crossAxisSpacing: isMobile ? 12 : 16,
                    mainAxisSpacing: isMobile ? 12 : 16,
                    childAspectRatio: isMobile ? 0.60 : 0.62,
                  ),
                  itemBuilder: (context, index) {
                    final p = backendProducts[index];
                    final id = p['_id']?.toString() ?? p['id']?.toString() ?? '';
                    final imageUrl = (p['images'] != null && (p['images'] as List).isNotEmpty)
                        ? p['images'][0].toString()
                        : (p['image']?.toString() ?? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500');
                    
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
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

