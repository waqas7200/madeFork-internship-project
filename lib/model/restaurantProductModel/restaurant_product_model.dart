// ─────────────────────────────────────────────
//  RESTAURANT PRODUCT MODEL
// ─────────────────────────────────────────────

class RestaurantProductModel {
  final String id;
  final String restaurantId;
  final String categoryId;
  final String title;
  final String description;
  final double price;
  final bool availability;
  final bool isSale;
  final double discount;
  final double total;
  final double rating;
  final String image;

  RestaurantProductModel({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.price,
    required this.availability,
    required this.isSale,
    required this.discount,
    required this.total,
    required this.rating,
    this.image = '',
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProductModel(
      id: json['id']?.toString() ?? '',
      restaurantId: json['restaurant_id']?.toString() ?? '',
      categoryId: json['category_id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Unnamed Product',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      availability: json['availability'] ?? true,
      isSale: json['is_sale'] ?? false,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      image: (json['product_images'] != null && (json['product_images'] as List).isNotEmpty)
          ? json['product_images'][0]['image_url']?.toString() ?? ''
          : '',
    );
  }
}
