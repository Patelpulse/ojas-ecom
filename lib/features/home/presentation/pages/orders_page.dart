import 'package:flutter/material.dart';
import 'package:ojas_user/core/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/features/orders/data/services/order_service.dart';
import 'package:ojas_user/features/orders/domain/models/order_model.dart';
import 'package:ojas_user/features/orders/presentation/pages/order_details_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrderService _orderService = OrderService();
  List<OrderModel> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    final orders = await _orderService.getUserOrders();
    if (mounted) {
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    }
  }

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
                  color: Colors.black87,
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
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: Color(0xFFF01B6B)))
              else if (_orders.isEmpty)
                _buildEmptyState(isMobile)
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _orders.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    return _orderCard(
                      context,
                      isMobile: isMobile,
                      order: _orders[index],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isMobile) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 24),
          Text(
            'No orders found',
            style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'You haven\'t placed any orders yet.',
            style: GoogleFonts.inter(color: Colors.black54),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/shop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF01B6B),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Start Shopping', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  List<Widget> _getSummaryCards(bool isMobile) {
    int pending = _orders.where((o) => o.status == 'Pending' || o.status == 'Processing' || o.status == 'Shipped').length;
    int delivered = _orders.where((o) => o.status == 'Delivered').length;
    int cancelled = _orders.where((o) => o.status == 'Cancelled').length;

    return [
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.inventory_2_outlined,
        count: _orders.length.toString(),
        label: 'Total Orders',
        color: const Color(0xFFF01B6B),
        isActive: true,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.history_toggle_off,
        count: pending.toString(),
        label: 'Pending',
        color: Colors.amber,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.task_alt,
        count: delivered.toString(),
        label: 'Delivered',
        color: Colors.green,
      ),
      _summaryCard(
        isMobile: isMobile,
        icon: Icons.cancel_outlined,
        count: cancelled.toString(),
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
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard(
    BuildContext context, {
    required bool isMobile,
    required OrderModel order,
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
                    order.orderId,
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
                            DateFormat('MM/dd/yyyy').format(order.createdAt),
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, size: 12, color: _getStatusColor(order.status)),
                            const SizedBox(width: 4),
                            Text(
                              order.status,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(order.status),
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
                    '\u20b9${order.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.hind(
                      fontSize: isMobile ? 22 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${order.items.length} item${order.items.length > 1 ? 's' : ''}',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: isMobile ? double.infinity : null,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(order: order),
                          ),
                        );
                      },
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
                    itemCount: order.items.length,
                    itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                            image: DecorationImage(
                              image: NetworkImage(ApiService.formatImageUrl(order.items[index].image)),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.amber;
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
        return Colors.orange;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
