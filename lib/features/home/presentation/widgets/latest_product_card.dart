import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double oldPrice;
  final double rating;
  final int ratingCount;
  final bool hasBestSellerBadge;

  const LatestProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.oldPrice,
    this.rating = 4.0,
    this.ratingCount = 100,
    this.hasBestSellerBadge = false,
  });

  @override
  State<LatestProductCard> createState() => _LatestProductCardState();
}

class _LatestProductCardState extends State<LatestProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _isHovered ? Colors.orange.shade300 : Colors.grey.shade200),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 6))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: widget.imageUrl.startsWith('http')
                      ? Image.network(widget.imageUrl, fit: BoxFit.cover)
                      : Image.asset(widget.imageUrl, fit: BoxFit.cover),
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
              ],
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rs. ${widget.price.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE53935),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Rs. ${widget.oldPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _StarRating(rating: widget.rating),
                ],
              ),
            ),
          ],
        ),
      ),
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
