import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/constants/app_colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(
      activeTitle: 'TRACK ORDERS',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        color: const Color(0xFFF8F9FA),
        child: CenteredContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'My Orders',
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track and manage your order history',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),

              // Summary Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _summaryCard(
                    icon: Icons.inventory_2_outlined,
                    count: '10',
                    label: 'Total Orders',
                    color: const Color(0xFFF01B6B),
                    isActive: true,
                  ),
                  _summaryCard(
                    icon: Icons.history_toggle_off,
                    count: '10',
                    label: 'Pending',
                    color: Colors.amber,
                  ),
                  _summaryCard(
                    icon: Icons.task_alt,
                    count: '0',
                    label: 'Delivered',
                    color: Colors.green,
                  ),
                  _summaryCard(
                    icon: Icons.cancel_outlined,
                    count: '0',
                    label: 'Cancelled',
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Order List
              _orderCard(
                orderId: 'ORD-059041-985',
                date: '2/16/2026',
                status: 'Pending',
                price: '3801.96',
                itemCount: 1,
                items: [
                  'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=200',
                ],
              ),
              const SizedBox(height: 24),
              _orderCard(
                orderId: 'ORD-885825-795',
                date: '1/14/2026',
                status: 'Pending',
                price: '103247.64',
                itemCount: 2,
                items: [
                  'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=200',
                  'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=200',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String count,
    required String label,
    required Color color,
    bool isActive = false,
  }) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? const Color(0xFFF01B6B) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            count,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard({
    required String orderId,
    required String date,
    required String status,
    required String price,
    required int itemCount,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 12, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              status,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\u20b9$price',
                    style: GoogleFonts.hind(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$itemCount item${itemCount > 1 ? 's' : ''}',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.open_in_new, size: 14),
                    label: const Text('View Details'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF01B6B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'Items: ',
                style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              ...items.map((url) => Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
