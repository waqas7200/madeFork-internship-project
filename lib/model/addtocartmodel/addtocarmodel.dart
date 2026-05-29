// Cart Item Model
// class CartItem {
//   final String id;
//   final String name;
//   final String price;
//   final String image;
//   final String size;
//   int quantity;
//
//   CartItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.size,
//     required this.quantity,
//   });
// }
class CartItem {
  final String id;
  final String name;
  final String price;
  final String image;
  final String size;
  final String restaurantId; // ✅ Resturent ki pehchan ke liye
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.size,
    required this.restaurantId, // ✅ Required field
    required this.quantity,
  });
}
