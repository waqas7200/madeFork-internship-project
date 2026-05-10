class ProductModel {
  final String id;
  final String name;
  final String store;
  final String price;
  final String image;
  final String description;
  final String location;
  final String category; // Added for UI consistency
  final double rating;
  final int reviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    required this.image,
    required this.description,
    required this.location,
    required this.category,
    required this.rating,
    required this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'store': store,
      'price': price,
      'image': image,
      'description': description,
      'location': location,
      'category': category,
      'rating': rating,
      'reviews': reviews,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      store: map['store'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviews: map['reviews'] ?? 0,
    );
  }
}