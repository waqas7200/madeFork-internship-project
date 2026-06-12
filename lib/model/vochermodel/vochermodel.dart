class Voucher {
  final String title;
  final String subtitle;
  final String discount;
  final String image;

  Voucher({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.image,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      title: json['title'],
      subtitle: json['subtitle'],
      discount: json['discount'],
      image: json['image'],
    );
  }
}
