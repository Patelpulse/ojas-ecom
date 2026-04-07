import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JustForYouCard extends StatefulWidget {
  final String imageUrl;
  final String brand;
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final bool hasBestSellerBadge;

  const JustForYouCard({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    this.hasBestSellerBadge = false,
  });

  @override
  State<JustForYouCard> createState() => _JustForYouCardState();
}

class _JustForYouCardState extends State<JustForYouCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(widget.imageUrl, fit: BoxFit.contain),
                    ),
                  ),
                  // Badges
                  if (widget.discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFF01B6B), borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          '--${widget.discount}%',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  if (widget.hasBestSellerBadge)
                    Positioned(
                      top: 8,
                      left: widget.discount > 0 ? 50 : 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange.shade800, borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          'BEST\nSELLER',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, height: 1.1),
                        ),
                      ),
                    ),
                  
                  // Hover Actions
                  if (_isHovered)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Column(
                        children: [
                          _hoverActionButton(Icons.favorite_border),
                          const SizedBox(height: 8),
                          _hoverActionButton(Icons.shopping_cart_outlined),
                        ],
                      ),
                    )
                ],
              ),
            ),
            
            // Details Area
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.brand,
                    style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rs. ${widget.price.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Rs. ${widget.oldPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _hoverActionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
      ),
      child: IconButton(
        icon: Icon(icon, size: 16, color: Colors.black87),
        onPressed: () {},
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
