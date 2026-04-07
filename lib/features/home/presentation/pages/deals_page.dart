import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  String _sortBy = 'Highest Discount';
  bool _isGridView = true;

  final List<_DealProduct> _deals = const [
    _DealProduct(
      name: 'Premium Wireless Headphones',
      vendor: 'SoundPro',
      category: 'Electronics',
      originalPrice: 15000,
      discountedPrice: 9999,
      discountPercent: 33,
      badge: 'Hot Deal',
      isWishlisted: false,
      stockPercent: 0.35,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&fit=crop',
    ),
    _DealProduct(
      name: 'Smart Watch Series 9',
      vendor: 'TechWear',
      category: 'Gadgets',
      originalPrice: 24999,
      discountedPrice: 18499,
      discountPercent: 26,
      badge: 'Bestseller',
      isWishlisted: true,
      stockPercent: 0.2,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&fit=crop',
    ),
    _DealProduct(
      name: 'Leather Messenger Bag',
      vendor: 'Urban Style',
      category: 'Accessories',
      originalPrice: 4500,
      discountedPrice: 2999,
      discountPercent: 33,
      badge: 'Clearance',
      isWishlisted: false,
      stockPercent: 0.5,
      imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&fit=crop',
    ),
    _DealProduct(
      name: 'Mechanical Gaming Keyboard',
      vendor: 'GamerX',
      category: 'Computing',
      originalPrice: 8999,
      discountedPrice: 5499,
      discountPercent: 38,
      badge: 'Hot Deal',
      isWishlisted: false,
      stockPercent: 0.65,
      imageUrl: 'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?w=500&fit=crop',
    ),
    _DealProduct(
      name: 'Coffee Maker Pro Espresso Machine',
      vendor: 'BrewMaster',
      category: 'Home Appliances',
      originalPrice: 12000,
      discountedPrice: 7999,
      discountPercent: 33,
      badge: 'Flash Sale',
      isWishlisted: false,
      stockPercent: 0.15,
      imageUrl: 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500&fit=crop',
    ),
    _DealProduct(
      name: 'Designer Sunglasses',
      vendor: 'LuxVibe',
      category: 'Fashion',
      originalPrice: 5500,
      discountedPrice: 3850,
      discountPercent: 30,
      badge: 'Best Deal',
      isWishlisted: true,
      stockPercent: 0.4,
      imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'DEALS',
      child: Container(
        color: const Color(0xFFF1F4F8),
        child: CenteredContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Header
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded, color: Color(0xFFEAB308), size: 32),
                        const SizedBox(width: 8),
                        Text(
                          'Hot Deals & Offers',
                          style: GoogleFonts.outfit(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Don't miss out on these amazing deals! Limited time offers with incredible savings.",
                      style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Filter & Sort Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_deals.length} deals found',
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF475569)),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _sortBy,
                              isDense: true,
                              style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF334155)),
                              items: ['Highest Discount', 'Lowest Price', 'Highest Price', 'Newest'].map((v) {
                                return DropdownMenuItem(value: v, child: Text(v));
                              }).toList(),
                              onChanged: (v) => setState(() => _sortBy = v!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _ViewToggleBtn(
                          icon: Icons.grid_view_rounded,
                          isActive: _isGridView,
                          onTap: () => setState(() => _isGridView = true),
                        ),
                        const SizedBox(width: 4),
                        _ViewToggleBtn(
                          icon: Icons.view_list_rounded,
                          isActive: !_isGridView,
                          onTap: () => setState(() => _isGridView = false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Product Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 420,
                ),
                itemCount: _deals.length,
                itemBuilder: (context, index) => _DealCard(product: _deals[index]),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Model ───────────────────────────────────────────────────────────────────
class _DealProduct {
  final String name;
  final String vendor;
  final String category;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final String badge;
  final bool isWishlisted;
  final double stockPercent;
  final String imageUrl;

  const _DealProduct({
    required this.name,
    required this.vendor,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.badge,
    required this.isWishlisted,
    required this.stockPercent,
    required this.imageUrl,
  });
}

// ─── Card ────────────────────────────────────────────────────────────────────
class _DealCard extends StatefulWidget {
  final _DealProduct product;
  const _DealCard({required this.product});

  @override
  State<_DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<_DealCard> {
  bool _wishlisted = false;

  @override
  void initState() {
    super.initState();
    _wishlisted = widget.product.isWishlisted;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              SizedBox(
                height: 210,
                width: double.infinity,
                child: p.imageUrl.startsWith('http')
                  ? Image.network(
                      p.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported_outlined, size: 60, color: Color(0xFFCBD5E1))),
                    )
                  : Image.asset(
                      p.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported_outlined, size: 60, color: Color(0xFFCBD5E1))),
                    ),
              ),
              // Discount badge (top-left)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF01B6B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '-${p.discountPercent}%',
                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              // Clearance badge (top-right-ish)
              Positioned(
                top: 12,
                right: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    p.badge,
                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF7C3AED)),
                  ),
                ),
              ),
              // Wishlist heart
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() => _wishlisted = !_wishlisted),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _wishlisted ? const Color(0xFFF01B6B) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
                    ),
                    child: Icon(
                      _wishlisted ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: _wishlisted ? Colors.white : const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Vendor & Category
                  Text(
                    '${p.vendor} • ${p.category}',
                    style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 8),

                  // Prices
                  Row(
                    children: [
                      Text(
                        '₹${p.discountedPrice.toInt()}',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${p.originalPrice.toInt()}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Stock bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: p.stockPercent,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFF01B6B)),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Limited Stock label
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_outlined, size: 14, color: Color(0xFFF01B6B)),
                      const SizedBox(width: 4),
                      Text(
                        'Limited Stock left',
                        style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFF01B6B), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  
                  const Spacer(), // Pushes the button to the bottom!

                  // Add to Cart button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                      label: Text('Add to Cart', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF01B6B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── View toggle button ───────────────────────────────────────────────────────
class _ViewToggleBtn extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  const _ViewToggleBtn({required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF01B6B) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? const Color(0xFFF01B6B) : const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 18, color: isActive ? Colors.white : const Color(0xFF64748B)),
      ),
    );
  }
}
