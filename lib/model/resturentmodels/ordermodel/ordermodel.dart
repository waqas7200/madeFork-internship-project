class Order {
  final String id;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String status; // Pending, Preparing, Completed
  final DateTime orderDate;

  Order({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.status,
    required this.orderDate,
  });

  /// Factory constructor to create Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      productImage: json['productImage'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
      status: json['status'] as String? ?? 'Pending',
      orderDate: json['orderDate'] != null
          ? DateTime.parse(json['orderDate'] as String)
          : DateTime.now(),
    );
  }

  /// Convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  /// Create a copy of Order with modified fields
  Order copyWith({
    String? id,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    String? status,
    DateTime? orderDate,
  }) {
    return Order(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  /// Get status color
  String getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return '#FFA500'; // Orange
      case 'preparing':
        return '#3B82F6'; // Blue
      case 'completed':
        return '#10B981'; // Green
      default:
        return '#6B7280'; // Gray
    }
  }
}
