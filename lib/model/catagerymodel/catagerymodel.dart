class catagery {
  final String id;
  final String name;
  final String store;
  final String price;
  final String image;
  final String description;
  final String location;
  final double rating;
  final int reviews;

  //<editor-fold desc="Data Methods">
  const catagery({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'store': this.store,
      'price': this.price,
      'image': this.image,
      'description': this.description,
      'rating': this.rating,
      'location': this.location,
      'reviews': this.reviews,
    };
  }

  factory catagery.fromMap(Map<String, dynamic> map) {
    return catagery(
      id: map['id'] as String,
      name: map['name'] as String,
      store: map['store'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      rating: map['rating'] as double,
      reviews: map['reviews'] as int,
      location: '',
    );
  }

  //</editor-fold>
}
