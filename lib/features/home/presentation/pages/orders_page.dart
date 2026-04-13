import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return OjasLayout(
      activeTitle: 'TRACK ORDERS',
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 60),
        color: const Color(0xFFF8F9FA),
        child: CenteredContent(
          horizontalPadding: isMobile ? 12 : 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'My Orders',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track and manage your order history',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),

              // Summary Cards
              if (isMobile)
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: _getSummaryCards(isMobile),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _getSummaryCards(isMobile).map((c) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: c))).toList(),
                ),
              const SizedBox(height: 48),

              // Order List
              _orderCard(
                context,
                isMobile: isMobile,
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
                context,
                isMobile: isMobile,
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

  List<Widget> _getSummaryCards(bool isMobile) {
    return [
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.inventory_2_outlined,
        count: '10',
        label: 'Total Orders',
        color: const Color(0xFFF01B6B),
        isActive: true,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.history_toggle_off,
        count: '10',
        label: 'Pending',
        color: Colors.amber,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.task_alt,
        count: '0',
        label: 'Delivered',
        color: Colors.green,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.cancel_outlined,
        count: '0',
        label: 'Cancelled',
        color: Colors.red,
      ),
    ];
  }

  Widget _summaryCard({
    required bool isMobile,
    required IconData icon,
    required String count,
    required String label,
    required Color color,
    bool isActive = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: isMobile ? 20 : 24),
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Text(
            count,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 12 : 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard(
    BuildContext context, {
    required bool isMobile,
    required String orderId,
    required String date,
    required String status,
    required String price,
    required int itemCount,
    required List<String> items,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Text(
                            date,
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
              if (isMobile) const SizedBox(height: 20),
              Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    '\u20b9$price',
                    style: GoogleFonts.hind(
                      fontSize: isMobile ? 22 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$itemCount item${itemCount > 1 ? 's' : ''}',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: isMobile ? double.infinity : null,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.open_in_new, size: 14),
                      label: const Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF01B6B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
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
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                            image: DecorationImage(
                              image: NetworkImage(items[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
