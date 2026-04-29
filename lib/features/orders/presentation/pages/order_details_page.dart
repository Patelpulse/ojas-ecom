import 'package:flutter/material.dart';
import 'package:ojas_user/core/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';
import 'package:ojas_user/core/widgets/centered_content.dart';
import 'package:ojas_user/core/constants/app_colors.dart';
import 'package:ojas_user/core/utils/responsive.dart';
import 'package:ojas_user/core/services/invoice_service.dart';
import '../../domain/models/order_model.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return OjasLayout(
      activeTitle: 'ORDER DETAILS',
      child: Container(
        color: const Color(0xFFF8F9FA),
        padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 60),
        child: CenteredContent(
          horizontalPadding: isMobile ? 16 : 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button & Title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Order Details',
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              if (isMobile)
                Column(
                  children: [
                    _orderSummaryCard(isMobile),
                    const SizedBox(height: 24),
                    _trackingCard(isMobile),
                    const SizedBox(height: 24),
                    _itemsCard(isMobile),
                    const SizedBox(height: 24),
                    _shippingCard(isMobile),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _trackingCard(isMobile),
                          const SizedBox(height: 24),
                          _itemsCard(isMobile),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        children: [
                          _orderSummaryCard(isMobile),
                          const SizedBox(height: 24),
                          _shippingCard(isMobile),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderSummaryCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Divider(height: 32),
          _summaryRow('Order ID', order.orderId),
          _summaryRow('Date', DateFormat('MMM dd, yyyy').format(order.createdAt)),
          _summaryRow('Status', order.status, isStatus: true),
          _summaryRow('Payment', order.paymentStatus, isStatus: true, statusColor: _getPaymentStatusColor()),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              Text(
                '\u20b9${order.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.hind(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFFF01B6B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: order.status == 'Delivered'
                  ? () async {
                      await InvoiceService.generateAndDownloadInvoice(order.toJson());
                    }
                  : null,
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Download Invoice'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF01B6B),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade200,
                disabledForegroundColor: Colors.grey.shade500,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
          if (order.status != 'Delivered')
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'Invoice will be available after delivery',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isStatus = false, Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: Colors.black87, fontSize: 14)),
          if (isStatus)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (statusColor ?? _getStatusColor(value)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor ?? _getStatusColor(value),
                ),
              ),
            )
          else
            Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _trackingCard(bool isMobile) {
    final List<String> statuses = order.status == 'Cancelled' 
        ? ['Pending', 'Cancelled']
        : ['Pending', 'Processing', 'Shipped', 'Delivered'];
    int currentIndex = statuses.indexOf(order.status);
    if (currentIndex == -1) currentIndex = 0; 

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Tracking',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              bool isCompleted = index <= currentIndex;
              bool isLast = index == statuses.length - 1;
              bool isCurrent = index == currentIndex;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isCompleted ? Colors.green : Colors.grey[200],
                          shape: BoxShape.circle,
                          border: isCurrent ? Border.all(color: Colors.green, width: 4) : null,
                        ),
                        child: isCompleted
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: index < currentIndex ? Colors.green : Colors.grey[200],
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statuses[index],
                          style: GoogleFonts.inter(
                            fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                            color: isCompleted ? Colors.black87 : Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        if (isCurrent)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Your order is currently ${statuses[index].toLowerCase()}',
                              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _itemsCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items (${order.items.length})',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Divider(height: 32),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                      image: DecorationImage(
                        image: NetworkImage(ApiService.formatImageUrl(item.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Qty: ${item.quantity}',
                          style: GoogleFonts.inter(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '\u20b9${(item.price * item.quantity).toStringAsFixed(2)}',
                    style: GoogleFonts.hind(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _shippingCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Divider(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFFF01B6B), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.shippingAddress.street,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.shippingAddress.city}, ${order.shippingAddress.state}',
                      style: GoogleFonts.inter(color: Colors.black87, fontSize: 14),
                    ),
                    Text(
                      order.shippingAddress.zipCode,
                      style: GoogleFonts.inter(color: Colors.black87, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
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

  Color _getPaymentStatusColor() {
    switch (order.paymentStatus) {
      case 'Paid':
        return Colors.green;
      case 'Unpaid':
        return Colors.amber;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
