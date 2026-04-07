import 'package:flutter/material.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:ojas_user/features/home/presentation/widgets/product_card.dart';
import 'package:ojas_user/features/home/presentation/widgets/section_title.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class FeaturedDealsSection extends StatelessWidget {
  const FeaturedDealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredProducts = ProductModel.dummyProducts.getRange(0, 3).toList();

    return CenteredContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            SectionTitle(title: 'Featured Deals of the Week', onSeeAll: null),
            const SizedBox(height: 32),
            Row(
              children: featuredProducts.map((product) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: ProductCard(
                      product: product,
                      onAddToCart: () {},
                    ),
                  ),
                );
              }).toList()..removeLast(),
            ),
          ],
        ),
      ),
    );
  }
}
