class DashboardStats {
  final String restaurantName;
  final int totalProducts;
  final int totalOrders;
  final double totalSales;

  DashboardStats({
    required this.restaurantName,
    required this.totalProducts,
    required this.totalOrders,
    required this.totalSales,
  });
}

class RecentOrder {
  final String id;
  final String productName;
  final String orderId;
  final double price;
  final int itemCount;
  final String status; // Pending, Preparing, Completed
  final String image;

  RecentOrder({
    required this.id,
    required this.productName,
    required this.orderId,
    required this.price,
    required this.itemCount,
    required this.status,
    required this.image,
  });
}
