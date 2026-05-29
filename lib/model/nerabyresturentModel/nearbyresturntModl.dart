class RestaurantModel {
  final String id;
  final String name;
  final String ownerName;
  final String address;
  final String image;
  final String rating;
  final double distanceInMeters;
  final String distanceStr;
  final String description;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.address,
    required this.image,
    required this.rating,
    required this.distanceInMeters,
    required this.distanceStr,
    required this.description,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json, double distance) {
    return RestaurantModel(
      id: json['id']?.toString() ?? '',
      name: json['shop_name']?.toString() ?? 'Unknown Shop',
      ownerName: json['owner_name']?.toString() ?? 'Unknown Owner',
      address: json['address']?.toString() ?? 'No address',
      image: json['profile_pic_url']?.toString() ?? 'https://via.placeholder.com/200',
      rating: '4.5', // Update if you have rating in DB
      distanceInMeters: distance,
      distanceStr: distance < 1000 ? '${distance.toStringAsFixed(0)} m' : '${(distance / 1000).toStringAsFixed(1)} km',
      description: json['description']?.toString() ?? 'No description available',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RestaurantModel &&
        other.id == id &&
        other.name == name &&
        other.ownerName == ownerName &&
        other.address == address &&
        other.image == image &&
        other.rating == rating &&
        other.distanceInMeters == distanceInMeters &&
        other.distanceStr == distanceStr &&
        other.description == description;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      ownerName,
      address,
      image,
      rating,
      distanceInMeters,
      distanceStr,
      description,
    );
  }
}

