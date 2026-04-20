import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _selectedCategory = 'All';
  String _selectedBrand = 'All';
  String _selectedPrice = 'All';
  String _selectedRating = 'All ratings';
  bool _inStockOnly = false;
  String _sortBy = 'Featured';

  List<dynamic> get _shopProducts {
    var list = HomeController.instance.products.toList();
    
    // 1. Filtering by Category
    if (_selectedCategory != 'All') {
      list = list.where((p) => (p['category'] ?? p['subCategory'] ?? '') == _selectedCategory).toList();
    }

    // 2. Sorting
    switch (_sortBy) {
      case 'Price: Low to High':
        list.sort((a, b) {
          final double pa = (a['discountPrice'] != null && a['discountPrice'] > 0 ? a['discountPrice'] : (a['price'] ?? 0)).toDouble();
          final double pb = (b['discountPrice'] != null && b['discountPrice'] > 0 ? b['discountPrice'] : (b['price'] ?? 0)).toDouble();
          return pa.compareTo(pb);
        });
        break;
      case 'Price: High to Low':
        list.sort((a, b) {
          final double pa = (a['discountPrice'] != null && a['discountPrice'] > 0 ? a['discountPrice'] : (a['price'] ?? 0)).toDouble();
          final double pb = (b['discountPrice'] != null && b['discountPrice'] > 0 ? b['discountPrice'] : (b['price'] ?? 0)).toDouble();
          return pb.compareTo(pa);
        });
        break;
      case 'Featured':
      default:
        // Sort by ID (Newest first)
        list.sort((a, b) => (b['_id'] ?? '').toString().compareTo((a['_id'] ?? '').toString()));
        break;
    }
    
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return ListenableBuilder(
      listenable: HomeController.instance,
      builder: (context, _) => OjasLayout(
        activeTitle: 'SHOP',
        child: Container(
          color: const Color(0xFFF8FAFC),
          child: CenteredContent(
            horizontalPadding: isMobile ? 12 : 20,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sidebar - hidden on mobile
                  if (!isMobile) ...[
                    _buildSidebar(),
                    const SizedBox(width: 30),
                  ],
                  
                  // Main Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopBar(isMobile),
                        const SizedBox(height: 20),
                        if (HomeController.instance.isLoading)
                          const Center(child: Padding(padding: EdgeInsets.all(100), child: CircularProgressIndicator())),
                        if (!HomeController.instance.isLoading && _shopProducts.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(100),
                              child: Column(
                                children: [
                                  const Icon(Icons.inventory_2_outlined, size: 60, color: Color(0xFFCBD5E1)),
                                  const SizedBox(height: 16),
                                  Text('No products found', style: GoogleFonts.outfit(fontSize: 18, color: const Color(0xFF64748B))),
                                ],
                              ),
                            ),
                          ),
                        if (!HomeController.instance.isLoading && _shopProducts.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _shopProducts.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isMobile ? 2 : (isTablet ? 2 : 3),
                              crossAxisSpacing: isMobile ? 12 : 20,
                              mainAxisSpacing: isMobile ? 12 : 20,
                              mainAxisExtent: isMobile ? 320 : 360,
                            ),
                            itemBuilder: (context, index) {
                              return _ShopProductCard(product: _shopProducts[index]);
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isMobile)
                Text(
                  '${_shopProducts.length} products found',
                  style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)),
                ),
              if (isMobile)
                _buildFilterButton(),
              Row(
                children: [
                  _buildSortDropdown(),
                  if (!isMobile) ...[
                    const SizedBox(width: 12),
                    _buildViewToggles(),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SingleChildScrollView(child: _buildSidebar()),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.filter_list, size: 20, color: Color(0xFFF01B6B)),
          const SizedBox(width: 8),
          Text(
            'Filters',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFF01B6B)),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          isDense: true,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.tune_rounded, size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.inter(
            fontSize: 13, 
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.w500,
          ),
          items: ['Featured', 'Price: Low to High', 'Price: High to Low'].map((v) {
            return DropdownMenuItem(
              value: v, 
              child: Text(v, style: GoogleFonts.inter(color: const Color(0xFF1E293B))),
            );
          }).toList(),
          onChanged: (v) => setState(() => _sortBy = v!),
        ),
      ),
    );
  }

  Widget _buildViewToggles() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF01B6B),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.grid_view, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.view_list, color: Colors.grey, size: 18),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sidebarTitle('Search Products'),
          const SizedBox(height: 12),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.search, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _sidebarTitle('Categories'),
          _radioGroup(
            ['All', ...HomeController.instance.categories.map((c) => (c['name'] ?? '').toString()).where((n) => n.isNotEmpty)], 
            _selectedCategory, 
            (v) => setState(() => _selectedCategory = v!)
          ),
          
          const SizedBox(height: 24),
          _sidebarTitle('Brands'),
          _radioGroup(['All', 'Official Store', 'Premium'], _selectedBrand, (v) => setState(() => _selectedBrand = v!)),
          
          const SizedBox(height: 24),
          _sidebarTitle('Price Range'),
          _radioGroup(['All', 'Under ₹50', '₹50 - ₹100', '₹100 - ₹200', '₹200+'], _selectedPrice, (v) => setState(() => _selectedPrice = v!)),
          
          const SizedBox(height: 24),
          _sidebarTitle('Minimum Rating'),
          _ratingGroup(['All ratings', '4 & up', '3 & up', '2 & up'], _selectedRating, (v) => setState(() => _selectedRating = v!)),
          
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 20, height: 20,
                child: Checkbox(value: _inStockOnly, onChanged: (v) => setState(() => _inStockOnly = v!), activeColor: const Color(0xFFF01B6B)),
              ),
              const SizedBox(width: 12),
              Text('In Stock Only', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sidebarTitle(String title) {
    return Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)));
  }

  Widget _radioGroup(List<String> options, String currentValue, ValueChanged<String?> onChanged) {
    return Column(
      children: options.map((option) {
        return InkWell(
          onTap: () => onChanged(option),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 16, height: 16,
                  child: Radio<String>(
                    value: option,
                    groupValue: currentValue,
                    onChanged: onChanged,
                    activeColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(option, style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569)))),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _ratingGroup(List<String> options, String currentValue, ValueChanged<String?> onChanged) {
    return Column(
      children: [
        // First is "All ratings"
        InkWell(
          onTap: () => onChanged(options[0]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 16, height: 16,
                  child: Radio<String>(value: options[0], groupValue: currentValue, onChanged: onChanged, activeColor: Colors.blueAccent),
                ),
                const SizedBox(width: 12),
                Text(options[0], style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569))),
              ],
            ),
          ),
        ),
        // Rest are stars
        for (int i = 1; i < options.length; i++)
          InkWell(
            onTap: () => onChanged(options[i]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 16, height: 16,
                    child: Radio<String>(value: options[i], groupValue: currentValue, onChanged: onChanged, activeColor: Colors.blueAccent),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: List.generate(5, (index) {
                      int startsCount = 5 - i;
                      return Icon(
                        index < startsCount ? Icons.star : Icons.star_border,
                        size: 14,
                        color: index < startsCount ? Colors.amber : Colors.grey.shade400,
                      );
                    }),
                  ),
                  const SizedBox(width: 6),
                  Text('& up', style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475569))),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ShopProductCard extends StatelessWidget {
  final dynamic product;

  const _ShopProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final String id = product['_id'] ?? '';
    final String name = product['name'] ?? 'Product';
    final String vendor = product['brand'] ?? 'Official Store';
    final double price = (product['discountPrice'] != null && product['discountPrice'] > 0 
        ? product['discountPrice'] 
        : (product['price'] ?? 0)).toDouble();
    final double oldPrice = (product['price'] ?? 0).toDouble();
    final int discount = oldPrice > 0 && oldPrice > price ? (((oldPrice - price) / oldPrice) * 100).toInt() : 0;
    final String imageUrl = product['image'] ?? 'https://via.placeholder.com/300';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Color(0x05000000), offset: Offset(0, 4), blurRadius: 10)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Box
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFF1F5F9),
                          child: const Center(child: Icon(Icons.image_not_supported_outlined, color: Color(0xFFCBD5E1))),
                        ),
                      ),
                    ),
                  ),
                ),
                // Discount Badge
                if (discount > 0)
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-$discount%',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                // Action Buttons
                Positioned(
                  top: 12, right: 12,
                  child: Column(
                    children: [
                      _actionButton(Icons.favorite_border, () {}),
                      const SizedBox(height: 8),
                      _actionButton(Icons.shopping_cart_outlined, () async {
                        final success = await CartController.instance.addToCart(id);
                         if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(success ? '$name added to cart' : 'Failed to add to cart. Please login first.'),
                              backgroundColor: success ? Colors.green : Colors.red,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor,
                    style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 15, 
                      fontWeight: FontWeight.bold, 
                      color: const Color(0xFF0F172A), 
                      height: 1.3
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '₹${price.toInt()}',
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      if (discount > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          '₹${oldPrice.toInt()}',
                          style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8), decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 4)],
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF475569)),
      ),
    );
  }
}
