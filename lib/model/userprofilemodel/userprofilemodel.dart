class UserProfile {
  final String name;
  final String location;
  final String image;
  final int ongoing;
  final int delivery;
  final int complete;

  UserProfile({
    required this.name,
    required this.location,
    required this.image,
    required this.ongoing,
    required this.delivery,
    required this.complete,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      location: json['location'],
      image: json['image'],
      ongoing: json['ongoing'],
      delivery: json['delivery'],
      complete: json['complete'],
    );
  }
}
