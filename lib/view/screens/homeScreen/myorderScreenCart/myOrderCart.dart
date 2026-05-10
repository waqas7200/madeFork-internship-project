// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class MyOrderScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(title: const Text("My Order", style: TextStyle(color: Colors.black))),
// //       body: ListView.builder(
// //         itemCount: 4,
// //         itemBuilder: (context, index) {
// //           return Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
// //             ),
// //             child: ListTile(
// //               contentPadding: const EdgeInsets.all(10),
// //               leading: ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image.network("https://your-image-url.com", width: 60, height: 60, fit: BoxFit.cover),
// //               ),
// //               title: const Text("Butter Shake 3", style: TextStyle(fontWeight: FontWeight.bold)),
// //               subtitle: const Text("P98.00", style: TextStyle(color: Color(0xFF00897B), fontWeight: FontWeight.bold)),
// //               trailing: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   _quantityBtn(Icons.remove),
// //                   const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("1")),
// //                   _quantityBtn(Icons.add, isAdd: true),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _quantityBtn(IconData icon, {bool isAdd = false}) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: isAdd ? const Color(0xFF00897B) : Colors.grey.shade100,
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Icon(icon, size: 20, color: isAdd ? Colors.white : Colors.black),
// //     );
// //   }
// // }
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../model/addtocartmodel/addtocarmodel.dart';
//
//
// // Global list جو سارے cart items رکھے گی
// List<CartItem> cartItems = [];
//
// class MyOrderScreen extends StatefulWidget {
//   @override
//   State<MyOrderScreen> createState() => _MyOrderScreenState();
// }
//
// class _MyOrderScreenState extends State<MyOrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("My Order", style: TextStyle(color: Colors.black)),
//         elevation: 0,
//         backgroundColor: Colors.white,
//       ),
//       body: cartItems.isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
//             const SizedBox(height: 16),
//             const Text(
//               "Your cart is empty",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           ],
//         ),
//       )
//           : ListView.builder(
//         itemCount: cartItems.length,
//         padding: const EdgeInsets.all(8),
//         itemBuilder: (context, index) {
//           final item = cartItems[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                 )
//               ],
//             ),
//             child: ListTile(
//               contentPadding: const EdgeInsets.all(10),
//               // Product Image - Leading میں
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   item.image,
//                   width: 60,
//                   height: 60,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     width: 60,
//                     height: 60,
//                     color: Colors.grey.shade200,
//                     child: Icon(Icons.image_not_supported),
//                   ),
//                 ),
//               ),
//               // Product Name اور Price
//               title: Text(
//                 item.name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 4),
//                   Text(
//                     item.price,
//                     style: const TextStyle(
//                       color: Color(0xFF00897B),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     "Size: ${item.size}",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ],
//               ),
//               // Quantity buttons - Trailing میں
//               trailing: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF0F8F6),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Remove button
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (item.quantity > 1) {
//                             item.quantity--;
//                           } else {
//                             cartItems.removeAt(index);
//                           }
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(6),
//                         child: Icon(
//                           Icons.remove,
//                           size: 18,
//                           color: Colors.grey.shade700,
//                         ),
//                       ),
//                     ),
//                     // Quantity
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         "${item.quantity}",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     // Add button
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           item.quantity++;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(6),
//                         child: Icon(
//                           Icons.add,
//                           size: 18,
//                           color: const Color(0xFF00897B),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../model/addtocartmodel/addtocarmodel.dart';

List<CartItem> cartItems = [];

class MyOrderScreen extends StatefulWidget {
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  CartItem? selectedItem;
  final TextEditingController _promoController = TextEditingController();
  bool _promoFieldVisible = false;
  final double deliveryFee = 30.0;

  double get subtotal {
    if (selectedItem == null) return 0;
    final price = double.tryParse(
        selectedItem!.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    return price * selectedItem!.quantity;
  }

  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Order", style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // ── Cart List ──
          cartItems.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text("Your cart is empty",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          )
              : ListView.builder(
            itemCount: cartItems.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final isSelected = selectedItem == item;

              // return GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       selectedItem = item;
              //     });
              //     _showBottomSheet(context);
              //   },
              //
              // );
              return Slidable(
                  key: ValueKey(item),

                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            cartItems.removeAt(index);
                            if (selectedItem == item) {
                              selectedItem = null;
                            }
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),

                  child: GestureDetector(
                  onTap: () {
                setState(() {
                  selectedItem = item;
                });
                _showBottomSheet(context);
              },
              child: Container(
              margin: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
              color: isSelected
              ? const Color(0xFF00897B)
                  : Colors.transparent,
              width: 1.5,
              ),
              boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              )
              ],
              ),
              child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
              item.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
              width: 60,
              height: 60,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported),
              ),
              ),
              ),
              title: Text(item.name,
              style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 4),
              Text(item.price,
              style: const TextStyle(
              color: Color(0xFF00897B),
              fontWeight: FontWeight.bold,
              fontSize: 13)),
              const SizedBox(height: 2),
              Text("Size: ${item.size}",
              style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11)),
              ],
              ),
              trailing: Container(
              decoration: BoxDecoration(
              color: const Color(0xFFF0F8F6),
              borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              GestureDetector(
              onTap: () {
              setState(() {
              if (item.quantity > 1) {
              item.quantity--;
              } else {
              cartItems.removeAt(index);
              if (selectedItem == item) {
              selectedItem = null;
              }
              }
              });
              },
              child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.remove,
              size: 18,
              color: Colors.grey.shade700),
              ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(
              horizontal: 10),
              child: Text("${item.quantity}",
              style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14)),
              ),
              GestureDetector(
              onTap: () {
              setState(() => item.quantity++);
              },
              child: Padding(
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.add,
              size: 18, color: Color(0xFF00897B)),
              ),
              ),
              ],
              ),
              ),
              ),
              ),));
            },
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Handle bar ──
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // ── Promo Code Row ──
                GestureDetector(
                  onTap: () {
                    setModalState(() {
                      _promoFieldVisible = !_promoFieldVisible;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer_outlined,
                            size: 18, color: Color(0xFF00897B)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _promoFieldVisible
                              ? TextField(
                            controller: _promoController,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Enter promo code",
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: 13),
                            onTap: () {},
                          )
                              : const Text("Apply promo code",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 14, color: Color(0xFF00897B)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Item Name & Subtotal ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedItem?.name ?? ''} x${selectedItem?.quantity ?? 1}",
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                    Text(
                      "P${subtotal.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // ── Delivery Fee ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delivery fee",
                        style: TextStyle(fontSize: 13, color: Colors.grey)),
                    Text("P${deliveryFee.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),

                const Divider(height: 24),

                // ── Total ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text("P${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00897B))),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Checkout Button ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Checkout logic yahan aayegi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Checkout",
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}