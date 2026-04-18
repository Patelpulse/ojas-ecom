import 'package:flutter/material.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/section_title.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class TrendingProductsSection extends StatelessWidget {
  const TrendingProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingProducts = ProductModel.dummyProducts;

    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            const SectionTitle(title: 'Trending Products', onSeeAll: null),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.72,
              ),
              itemCount: trendingProducts.length,
              itemBuilder: (context, index) {
                final product = trendingProducts[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () async {
                    final success = await CartController.instance.addToCart(product.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(success ? '${product.name} added to cart!' : 'Failed. Please login.'),
                        backgroundColor: success ? Colors.green : Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ));
                    }
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
