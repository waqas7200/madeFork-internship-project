// ─────────────────────────────────────────────
//  ORDER LISTING SCREEN  (User Side)
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/order_tracking_controller/order_tracking_controller.dart';
import '../../../model/order_tracking_model/order_tracking_model.dart';
import 'order_detail_screen/order_detail_screen.dart';
import '../../component/custom_home_appbar.dart';
import '../../component/custom_background/custom_background.dart';
import '../../component/custom_loading_widget.dart';

class UserOrderHistoryScreen extends StatelessWidget {
  UserOrderHistoryScreen({super.key});

  final OrderTrackingController ctrl = Get.put(
    OrderTrackingController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomHomeAppBar(
                showBackButton: false,
                titleLine1: 'My',
                titleLine2: 'Orders',
                trailing: IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Color(0xFF00897B),
                  ),
                  onPressed: ctrl.fetchOrders,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (ctrl.isLoading.value && ctrl.orders.isEmpty) {
                    return const Center(child: CustomLoadingWidget());
                  }
                  if (ctrl.errorMessage.value.isNotEmpty) {
                    return _ErrorView(
                      message: ctrl.errorMessage.value,
                      onRetry: ctrl.fetchOrders,
                    );
                  }
                  if (ctrl.orders.isEmpty) {
                    return const _EmptyView();
                  }
                  return RefreshIndicator(
                    color: const Color(0xFF00897B),
                    onRefresh: ctrl.fetchOrders,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: ctrl.orders.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) =>
                          _OrderCard(order: ctrl.orders[i]),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Order Card ────────────────────────────────────────────────────────────
class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final OrderTrackingModel order;

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(order.createdAt);
    final statusColor = _statusColor(order.status);
    final statusBg = statusColor.withValues(alpha: 0.12);

    return GestureDetector(
      onTap: () => Get.to(
        () => OrderDetailScreen(order: order),
        transition: Transition.cupertino,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ───────────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00897B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Color(0xFF00897B),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.restaurantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Order #${order.id.substring(0, 8).toUpperCase()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              const SizedBox(height: 12),

              // ── Date & items row ─────────────────────────────────
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.fastfood_rounded,
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${order.items.length} item${order.items.length != 1 ? 's' : ''}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ── Total & arrow ────────────────────────────────────
              Row(
                children: [
                  Text(
                    'Rs. ${order.totalAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF00897B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Color(0xFF00897B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (_) {
      return iso;
    }
  }

  Color _statusColor(OrderStatus s) {
    switch (s) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.accepted:
        return const Color(0xFF00897B);
      case OrderStatus.rejected:
        return Colors.red;
      case OrderStatus.onHold:
        return Colors.deepOrange;
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.ready:
        return Colors.indigo;
      case OrderStatus.dispatched:
        return Colors.purple;
      case OrderStatus.delivered:
        return const Color(0xFF2E7D32);
      default:
        return Colors.grey;
    }
  }
}

// ─── Empty state ────────────────────────────────────────────────────────────
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF00897B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(45),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              size: 44,
              color: Color(0xFF00897B),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your order history will appear here\nonce you place your first order.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ─── Error state ─────────────────────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00897B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
