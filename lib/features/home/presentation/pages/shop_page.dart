import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/utils/responsive.dart';

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

  // Dummy data exactly matching the provided image
  final List<Map<String, dynamic>> _shopProducts = [
    {
      'id': '1',
      'name': 'test',
      'vendor': 'RUDRAM',
      'price': 99.0,
      'oldPrice': 100.0,
      'discount': 1,
      'imageUrl': 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': '2',
      'name': 'Aerofit Spin Bike AF-780 (Yellow/Black) – 12 kg High Iner...',
      'vendor': 'Unknown Brand',
      'price': 34499.0,
      'oldPrice': 42999.0,
      'discount': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': '3',
      'name': 'Storio Soft Toy Unicorn Plushie – Soft Cuddly Toy for Kids',
      'vendor': 'Unknown Brand',
      'price': 358.0,
      'oldPrice': 500.0,
      'discount': 68,
      'imageUrl': 'https://images.unsplash.com/photo-1559454403-b8fb88521f11?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': '4',
      'name': 'How to Win Friends and Influence People',
      'vendor': 'Unknown Brand',
      'price': 396.0,
      'oldPrice': 700.0,
      'discount': 77,
      'imageUrl': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': '5',
      'name': 'Black Color Laptop',
      'vendor': 'Yogesh',
      'price': 52999.0,
      'oldPrice': 70000.0,
      'discount': 32,
      'imageUrl': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': '6',
      'name': 'Luxury Gold Plated Smartwatch',
      'vendor': 'RUDRAM',
      'price': 499.99,
      'oldPrice': 699.99,
      'discount': 40,
      'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return OjasLayout(
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF334155)),
          items: ['Featured', 'Price: Low to High', 'Price: High to Low'].map((v) {
            return DropdownMenuItem(value: v, child: Text(v));
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
          _radioGroup(['All', 'Industrial Parts & Tools', 'Health & Fitness', 'Toys & Games', 'Books & Stationery', 'Gadgets'], _selectedCategory, (v) => setState(() => _selectedCategory = v!)),
          
          const SizedBox(height: 24),
          _sidebarTitle('Brands'),
          _radioGroup(['All', 'RUDRAM', 'Unknown Brand', 'Yogesh'], _selectedBrand, (v) => setState(() => _selectedBrand = v!)),
          
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
  final Map<String, dynamic> product;

  const _ShopProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
                        product['imageUrl'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Discount Badge
                if (product['discount'] > 0)
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product['discount']}%',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                // Action Buttons
                Positioned(
                  top: 12, right: 12,
                  child: Column(
                    children: [
                      _actionButton(Icons.favorite_border),
                      const SizedBox(height: 8),
                      _actionButton(Icons.shopping_cart_outlined),
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
                    product['vendor'],
                    style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B), height: 1.4),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '₹${product['price'].toInt()}',
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${product['oldPrice'].toInt()}',
                        style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF94A3B8), decoration: TextDecoration.lineThrough),
                      ),
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

  Widget _actionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 4)],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Icon(icon, size: 14, color: const Color(0xFF475569)),
    );
  }
}
