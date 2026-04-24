import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/controllers/wishlist_controller.dart';

class LatestProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double oldPrice;
  final double rating;
  final int ratingCount;
  final bool hasBestSellerBadge;
  final String? productId;
  final VoidCallback? onAddToCart;

  const LatestProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.oldPrice,
    this.rating = 4.0,
    this.ratingCount = 100,
    this.hasBestSellerBadge = false,
    this.productId,
    this.onAddToCart,
  });

  @override
  State<LatestProductCard> createState() => _LatestProductCardState();
}

class _LatestProductCardState extends State<LatestProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: WishlistController.instance,
      builder: (context, _) {
        final bool isWishlisted = widget.productId != null && WishlistController.instance.isWishlisted(widget.productId!);
        
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _isHovered ? Colors.orange.shade300 : Colors.grey.shade200),
              boxShadow: _isHovered
                  ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 6))]
                  : [],
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image area
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, __) => const Center(
                              child: Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      if (widget.hasBestSellerBadge)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade800,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'BEST\nSELLER',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),
                      // Wishlist Heart
                      if (widget.productId != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              final productMap = {
                                '_id': widget.productId,
                                'name': widget.title,
                                'price': widget.price,
                                'images': [widget.imageUrl],
                              };
                              WishlistController.instance.toggleWishlist(productMap);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                                ],
                              ),
                              child: Icon(
                                isWishlisted ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: isWishlisted ? const Color(0xFFF01B6B) : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '₹${widget.price.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '₹${widget.oldPrice.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        _StarRating(rating: widget.rating),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: widget.onAddToCart,
                            icon: const Icon(Icons.shopping_cart_outlined, size: 14),
                            label: Text('Add to Cart',
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE91E63),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final full = index < rating.floor();
        final half = !full && index < rating;
        return Icon(
          full ? Icons.star : (half ? Icons.star_half : Icons.star_border),
          color: Colors.orange,
          size: 14,
        );
      }),
    );
  }
}
