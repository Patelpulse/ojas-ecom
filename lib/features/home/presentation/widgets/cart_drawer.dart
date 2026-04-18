import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double oldPrice;
  final int discount;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  final List<CartItem> _dummyItems = [
    CartItem(
      id: '1',
      name:
          'Aerofit Spin Bike AF-780 (Yellow/Black) \u2013 12 kg High Inertia...',
      brand: 'Patel Pulse V.',
      price: 34499,
      oldPrice: 42999,
      discount: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=400',
    ),
    CartItem(
      id: '2',
      name: 'Black Color Laptop',
      brand: 'Yogesh',
      price: 52999,
      oldPrice: 70000,
      discount: 24,
      imageUrl:
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double savings = 0;
    for (var item in _dummyItems) {
      subtotal += item.price * item.quantity;
      savings += (item.oldPrice - item.price) * item.quantity;
    }
    const double tax = 6999.84;
    final double total = subtotal + tax;

    return Drawer(
      width: 450,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF01B6B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shopping Cart',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${_dummyItems.length} items',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Cart Items List
          Expanded(
            child: _dummyItems.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: _dummyItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildCartItem(_dummyItems[index]);
                    },
                  ),
          ),

          if (_dummyItems.isNotEmpty) ...[
            const Divider(height: 1),
            // Checkout Summary
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Subtotal',
                    '\u20b9${subtotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'You saved',
                    '-\u20b9${savings.toStringAsFixed(2)}',
                    valueColor: const Color(0xFF2E7D32),
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'Shipping',
                    'FREE',
                    valueColor: const Color(0xFF2E7D32),
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'Tax',
                    '\u20b9${tax.toStringAsFixed(2)}',
                    valueColor: Colors.grey[300]!,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '\u20b9${total.toStringAsFixed(2)}',
                        style: GoogleFonts.hind(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(
                            0xFFB71C1C,
                          ), // Maroon-ish red as in image
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF01B6B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to Checkout',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Discount Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB1B4F),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${item.discount}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.brand,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\u20b9${item.price.toInt()}',
                      style: GoogleFonts.hind(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\u20b9${item.oldPrice.toInt()}',
                      style: GoogleFonts.hind(
                        fontSize: 14,
                        color: Colors.grey[400],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Quantity and Delete row
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _quantityButton(Icons.remove, () {
                            if (item.quantity > 1) {
                              setState(() => item.quantity--);
                            }
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _quantityButton(Icons.add, () {
                            setState(() => item.quantity++);
                          }),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFFB1B4F),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _dummyItems.removeWhere((i) => i.id == item.id);
                        });
                      },
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

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, size: 16, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: label == 'You saved' || label == 'Shipping'
                ? const Color(0xFF2E7D32)
                : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: label == 'Total' ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Your cart is empty',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Add some products to get started',
          style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[500]),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF01B6B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Continue Shopping',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
