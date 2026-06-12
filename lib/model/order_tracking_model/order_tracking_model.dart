// ─────────────────────────────────────────────
//  ORDER TRACKING MODEL
// ─────────────────────────────────────────────

/// All possible order statuses supported by the system
enum OrderStatus {
  pending,
  accepted,
  rejected,
  onHold,
  preparing,
  ready,
  dispatched,
  delivered,
  unknown,
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.rejected:
        return 'Rejected';
      case OrderStatus.onHold:
        return 'On Hold';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.dispatched:
        return 'Dispatched';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.unknown:
        return 'Unknown';
    }
  }
}

OrderStatus orderStatusFromString(String? s) {
  switch (s?.toLowerCase()) {
    case 'pending':
      return OrderStatus.pending;
    case 'accepted':
      return OrderStatus.accepted;
    case 'rejected':
    case 'cancelled':
      return OrderStatus.rejected;
    case 'on_hold':
    case 'onhold':
    case 'on hold':
      return OrderStatus.onHold;
    case 'preparing':
      return OrderStatus.preparing;
    case 'ready':
      return OrderStatus.ready;
    case 'dispatched':
    case 'dispatch':
      return OrderStatus.dispatched;
    case 'delivered':
    case 'completed':
      return OrderStatus.delivered;
    default:
      return OrderStatus.unknown;
  }
}

/// A single step shown in the timeline
class TimelineStep {
  final OrderStatus status;
  final String? dateTime; // ISO string from DB

  const TimelineStep({required this.status, this.dateTime});
}

/// Full order model for user-side tracking
class OrderTrackingModel {
  final String id;
  final String restaurantName;
  final String restaurantId;
  final String address;
  final double totalAmount;
  final String paymentMethod;
  final OrderStatus status;
  final String? orderStage;
  final String createdAt;
  final String updatedAt;
  final List<OrderItemLine> items;

  const OrderTrackingModel({
    required this.id,
    required this.restaurantName,
    required this.restaurantId,
    required this.address,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    this.orderStage,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderTrackingModel.fromMap(Map<String, dynamic> map) {
    final restaurant = map['restaurants'] as Map<String, dynamic>? ?? {};
    final rawItems = map['order_items'] as List<dynamic>? ?? [];

    final dbStatus = map['status']?.toString();
    final dbStage = map['order_stage']?.toString();

    // If status is 'accepted' but a specific order_stage exists, use order_stage for tracking state
    final statusString =
        (dbStatus == 'accepted' && dbStage != null && dbStage.isNotEmpty)
        ? dbStage
        : dbStatus;

    return OrderTrackingModel(
      id: map['id']?.toString() ?? '',
      restaurantId: map['restaurant_id']?.toString() ?? '',
      restaurantName: restaurant['name']?.toString() ?? 'Restaurant',
      address: map['address']?.toString() ?? '',
      totalAmount:
          double.tryParse(map['total_amount']?.toString() ?? '0') ?? 0.0,
      paymentMethod: map['payment_method']?.toString() ?? '',
      status: orderStatusFromString(statusString),
      orderStage: dbStage,
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
      items: rawItems
          .map((e) => OrderItemLine.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Returns the ordered timeline steps up to the current status
  List<TimelineStep> get timelineSteps {
    const flow = [
      OrderStatus.pending,
      OrderStatus.accepted,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.dispatched,
      OrderStatus.delivered,
    ];
    return flow
        .map(
          (s) =>
              TimelineStep(status: s, dateTime: s == status ? updatedAt : null),
        )
        .toList();
  }

  /// Index of current status in the happy-path flow (-1 if not in flow)
  int get currentStepIndex {
    const flow = [
      OrderStatus.pending,
      OrderStatus.accepted,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.dispatched,
      OrderStatus.delivered,
    ];
    return flow.indexOf(status);
  }
}

class OrderItemLine {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const OrderItemLine({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemLine.fromMap(Map<String, dynamic> map) {
    final product = map['products'] as Map<String, dynamic>? ?? {};
    return OrderItemLine(
      productId: map['product_id']?.toString() ?? '',
      productName: product['name']?.toString() ?? 'Item',
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
    );
  }
}
