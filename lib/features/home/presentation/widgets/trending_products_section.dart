import 'package:flutter/material.dart';
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
                return ProductCard(
                  product: trendingProducts[index],
                  onAddToCart: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
