class OrderItem {
  final String name;
  final String date;
  final String price;
  final String image;

  OrderItem({
    required this.name,
    required this.date,
    required this.price,
    required this.image,
  });

  // FROM MAP
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
    );
  }

  // TO MAP
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'price': price,
      'image': image,
    };
  }

  // FROM JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem.fromMap(json);
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return toMap();
  }
}