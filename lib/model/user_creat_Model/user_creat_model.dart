class UserModel {
  final String id;
  final String userId;
  final String username;
  final String email;
  final String? phone;
  final String? profileImage;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    this.phone,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      profileImage: map['profile_image'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
    };
  }

  UserModel copyWith({String? username, String? phone, String? profileImage}) {
    return UserModel(
      id: id,
      userId: userId,
      username: username ?? this.username,
      email: email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}
