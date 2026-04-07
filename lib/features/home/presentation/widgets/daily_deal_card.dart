import 'package:flutter/material.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/features/home/domain/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyDealCard extends StatelessWidget {
  final ProductModel product;

  const DailyDealCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double progress = (product.sold ?? 0) / ((product.available ?? 1) + (product.sold ?? 0));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image & Badge
          Stack(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: product.imageUrl.startsWith('http')
                        ? NetworkImage(product.imageUrl) as ImageProvider
                        : AssetImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF01B6B),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '-${product.discount}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 24),
          
          // 2. Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '₹${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF01B6B),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (product.oldPrice != null)
                      Text(
                        '₹${product.oldPrice!.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'They key to have more time is to them well, but we love them anyway. Premium quality guaranteed.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 20),
                
                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Available: ${product.available}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Text('Sold: ${product.sold}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFF01B6B))),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF01B6B)),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Buttons
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove_red_eye_outlined, size: 20, color: Colors.grey),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF01B6B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
