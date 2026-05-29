// import 'package:flutter/material.dart';
// import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../../model/paymentmodel/paymentmodel.dart';
// import '../../component/customCircleAvator/customCircleavators.dart';
// import '../../utils/responsiveClass/responosiveC;ass.dart';
// import '../bottomNavigationBar/bottomNavgationBar.dart';
// import '../ordersuccessscreen/ordersuccessscreen.dart';
// import '../homeScreen/myorderScreenCart/myOrderCart.dart';
//
// class PaymentMethodScreen extends StatefulWidget {
//   final bool isFromCheckout;
//   final double subtotal;
//   final double deliveryFee;
//   final double total;
//   final String deliveryAddress;
//
//   const PaymentMethodScreen({
//     super.key,
//     this.isFromCheckout = false,
//     this.subtotal = 0.0,
//     this.deliveryFee = 0.0,
//     this.total = 0.0,
//     this.deliveryAddress = "",
//   });
//
//   @override
//   State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
// }
//
// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//   // Mock Data mimicking API Response
//   final List<Map<String, dynamic>> rawCards = [
//     {'cardNumber': '7741 6588 2123 6644', 'holderName': 'JORDAN WATSON', 'cardColor': '0xFF2D3436', 'brand': 'VISA'},
//     {'cardNumber': '3341 6888 1234 5678', 'holderName': 'JORDAN BLACK', 'cardColor': '0xFF00897B', 'brand': 'VISA'},
//   ];
//
//   final List<Map<String, dynamic>> rawOptions = [
//     {'title': 'Pay', 'balance': 'Balance: \$1,340', 'iconCode': 0xf04ee}, // Apple icon code
//     {'title': 'PayPal', 'balance': 'Balance: \$3,341', 'iconCode': 0xf04eb}, // Payment icon code
//     {'title': 'GCash', 'balance': 'Balance: \$5,334', 'iconCode': 0xef3e},  // Wallet icon code
//   ];
//
//   late List<CreditCardModel> cardList;
//   late List<PaymentOptionModel> optionList;
//   String selectedMethod = "Apple Pay";
//   bool _isSavingOrder = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Converting Maps to Models using Factory
//     cardList = rawCards.map((m) => CreditCardModel.fromMap(m)).toList();
//     optionList = rawOptions.map((m) => PaymentOptionModel.fromMap(m)).toList();
//   }
//
//   bool _isValidUuid(String id) {
//     final regExp = RegExp(
//       r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
//       caseSensitive: false,
//     );
//     return regExp.hasMatch(id);
//   }
//
//   Future<void> _placeOrderAndPay() async {
//     setState(() {
//       _isSavingOrder = true;
//     });
//
//     try {
//       final supabase = Supabase.instance.client;
//
//       // 1. Get current logged in user ID if any
//       final String? userId = supabase.auth.currentUser?.id;
//
//       // 2. Fetch the first restaurant UUID to associate the order correctly
//       String? restaurantId;
//       try {
//         final restaurantsResponse = await supabase.from('restaurants').select('id').limit(1);
//         if (restaurantsResponse.isNotEmpty) {
//           restaurantId = restaurantsResponse.first['id'] as String?;
//         }
//       } catch (e) {
//         print("Error fetching restaurant ID: $e");
//       }
//
//       // 3. Create Order Record in 'orders' table
//       final orderData = {
//         'restaurant_id': restaurantId,
//         'user_id': userId,
//         'total_amount': widget.total,
//         'status': 'pending',
//         'address': widget.deliveryAddress.isNotEmpty ? widget.deliveryAddress : 'Default Address',
//         'payment_method': selectedMethod,
//         'cash_received': selectedMethod == 'Cash on Delivery' || selectedMethod == 'Cash',
//       };
//
//       final orderResponse = await supabase.from('orders').insert(orderData).select('id').single();
//       final String orderId = orderResponse['id'] as String;
//
//       // 4. Create Order Items in 'order_items' table
//       // We will check if product IDs in cart are valid UUIDs, if not we fall back to a database product UUID or null
//       String? fallbackProductId;
//       try {
//         final productsResponse = await supabase.from('products').select('id').limit(1);
//         if (productsResponse.isNotEmpty) {
//           fallbackProductId = productsResponse.first['id'] as String?;
//         }
//       } catch (e) {
//         print("Error fetching product fallback: $e");
//       }
//
//       final List<Map<String, dynamic>> itemsToInsert = [];
//       for (var item in cartItems) {
//         final double itemPrice = double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
//         final String? prodId = _isValidUuid(item.id)
//             ? item.id
//             : fallbackProductId; // Use real fallback product UUID or null to prevent Postgres UUID format errors
//
//         itemsToInsert.add({
//           'order_id': orderId,
//           'product_id': prodId,
//           'quantity': item.quantity,
//           'price': itemPrice,
//         });
//       }
//
//       if (itemsToInsert.isNotEmpty) {
//         await supabase.from('order_items').insert(itemsToInsert);
//       }
//
//       // 5. Create Payment Record in 'payments' table
//       final paymentData = {
//         'order_id': orderId,
//         'amount': widget.total,
//         'method': selectedMethod,
//         'status': 'paid',
//         'transaction_id': 'TXN-${DateTime.now().millisecondsSinceEpoch}',
//         'paid_at': DateTime.now().toIso8601String(),
//       };
//
//       await supabase.from('payments').insert(paymentData);
//
//       // 6. Success: Navigate to success screen
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const OrderSuccessScreen(),
//           ),
//         );
//       }
//     } catch (e) {
//       print("Error placing order: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed to place order: $e"),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isSavingOrder = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const Color primaryYellow = Color(0xFFF5A623);
//
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: const Color(0xFFF8F8F8),
//           appBar: AppBar(
//             backgroundColor:AppColor.backgroundYellow,
//             elevation: 0,
//             scrolledUnderElevation: 0,
//             toolbarHeight: context.rH(10),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: _circleBtn(Icons.arrow_back),
//                 ),
//                 const Text("Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Row(
//                   children: [
//                     const Icon(Icons.shopping_cart_outlined),
//                     const SizedBox(width: 10),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(color: Colors.white, height: 35, width: 35,
//                           child: const Icon(Icons.person)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//           ),
//           body: Stack(
//             children: [
//               Positioned(
//                 top: -490,
//                 right: -95,
//                 child: BackgroundCircle(size:600, color: AppColor.backgroundYellow),
//               ),
//
//               Positioned.fill(
//                 child: ListView(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildSectionTitle("Credit Cards", showAdd: true),
//
//                     // Horizontal Cards
//                     SizedBox(
//                       height: 190,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: cardList.length,
//                         itemBuilder: (context, index) => _cardWidget(cardList[index]),
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//                     _buildSectionTitle("Other option"),
//                     const SizedBox(height: 15),
//
//                     // Options List
//                     ...optionList.map((opt) => _optionWidget(opt)).toList(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           bottomNavigationBar: widget.isFromCheckout
//               ? Container(
//                   padding: EdgeInsets.fromLTRB(context.rW(4), context.rH(1.5), context.rW(4), context.rH(3.5)),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, -4),
//                       )
//                     ],
//                   ),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       onPressed: _placeOrderAndPay,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.backgroundBlue,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         elevation: 0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Pay with $selectedMethod",
//                             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                           const SizedBox(width: 8),
//                           const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : null,
//         ),
//         if (_isSavingOrder)
//           Container(
//             color: Colors.black.withOpacity(0.55),
//             child: Center(
//               child: Card(
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(AppColor.backgroundBlue),
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         "Processing Order & Payment...",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, decoration: TextDecoration.none, color: Colors.black87),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "Please do not close the app",
//                         style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//
//   Widget _cardWidget(CreditCardModel card) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: 320,
//         margin: const EdgeInsets.only(right: 5),
//         decoration: BoxDecoration(
//           color: card.cardColor,
//           borderRadius: BorderRadius.circular(25),
//         ),
//         // Stack use kar rahe hain taaki circles background mein jayen
//         child: Stack(
//           children: [
//             // 1. Left Side Circle (Halka grey, Visa ke niche)
//             Positioned(
//               top: -10,
//               left: -25,
//               child: CircleAvatar(
//                 radius: 60,
//                 backgroundColor: Colors.white.withOpacity(0.05), // Boht halka grey/white effect
//               ),
//             ),
//
//             // 2. Bottom Right Circle (Sirf Border/Lines wala)
//             Positioned(
//               bottom: 20,
//               right: -20,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.1), // Halka grey line effect
//                     width: 5,
//                   ),
//                 ),
//               ),
//             ),
//
//             // Main Content (Jo pehle se tha)
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     card.brand,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   Text(
//                     card.cardNumber,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         card.holderName,
//                         style: const TextStyle(color: Colors.white70, fontSize: 11),
//                       ),
//                       const Icon(Icons.contactless, color: Colors.white, size: 24),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _optionWidget(PaymentOptionModel opt) {
//     bool isSelected = selectedMethod == opt.title;
//     return GestureDetector(
//       onTap: () => setState(() => selectedMethod = opt.title),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 15),
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: isSelected ? const Color(0xFFF5A623) : Colors.transparent),
//         ),
//         child: ListTile(
//           leading: Icon(opt.icon, size: 30, color: Colors.blueGrey),
//           title: Text(opt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//           subtitle: Text(opt.balance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           trailing: Radio<String>(
//             value: opt.title,
//             groupValue: selectedMethod,
//             activeColor: const Color(0xFFF5A623),
//             onChanged: (v) => setState(() => selectedMethod = v!),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title, {bool showAdd = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10,),
//             child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ),
//           if (showAdd) Padding(
//             padding: const EdgeInsets.only(right: 40),
//             child: CircleAvatar(
//                 backgroundColor:AppColor.backgroundBlue ,
//                 child: const Icon(Icons.add, color: Colors.white,size: 35,)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _circleBtn(IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//       child: Icon(icon, size: 20, color: Colors.black),
//     );
//   }
//
//
//
//
// }

import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../model/paymentmodel/paymentmodel.dart';
import '../../component/customCircleAvator/customCircleavators.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';
import '../ordersuccessscreen/ordersuccessscreen.dart';
import '../homeScreen/myorderScreenCart/myOrderCart.dart';

class PaymentMethodScreen extends StatefulWidget {
  final bool isFromCheckout;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String deliveryAddress;

  const PaymentMethodScreen({
    super.key,
    this.isFromCheckout = false,
    this.subtotal = 0.0,
    this.deliveryFee = 0.0,
    this.total = 0.0,
    this.deliveryAddress = "",
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Mock Data mimicking API Response
  final List<Map<String, dynamic>> rawCards = [
    {'cardNumber': '7741 6588 2123 6644', 'holderName': 'JORDAN WATSON', 'cardColor': '0xFF2D3436', 'brand': 'VISA'},
    {'cardNumber': '3341 6888 1234 5678', 'holderName': 'JORDAN BLACK', 'cardColor': '0xFF00897B', 'brand': 'VISA'},
  ];

  final List<Map<String, dynamic>> rawOptions = [
    {'title': 'Pay', 'balance': 'Balance: \$1,340', 'iconCode': 0xf04ee},
    {'title': 'PayPal', 'balance': 'Balance: \$3,341', 'iconCode': 0xf04eb},
    {'title': 'GCash', 'balance': 'Balance: \$5,334', 'iconCode': 0xef3e},
  ];

  late List<CreditCardModel> cardList;
  late List<PaymentOptionModel> optionList;
  String selectedMethod = "PayPal"; // Default standard
  bool _isSavingOrder = false;

  @override
  void initState() {
    super.initState();
    cardList = rawCards.map((m) => CreditCardModel.fromMap(m)).toList();
    optionList = rawOptions.map((m) => PaymentOptionModel.fromMap(m)).toList();
  }

  bool _isValidUuid(String id) {
    final regExp = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return regExp.hasMatch(id);
  }

  /// ── LIVE DYNAMIC ORDER PLACEMENT FUNCTION ──
  Future<void> _placeOrderAndPay() async {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty!"), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() {
      _isSavingOrder = true;
    });

    try {
      final supabase = Supabase.instance.client;

      // 1. Logged in user verification
      final String? userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception("User session not found. Please log in again.");
      }

      // 2. LIVE DYNAMIC ID DETECT: Hardcoding khatam, cart ke real product se ID nikal li
      String realRestaurantId = cartItems.first.restaurantId;
      print("🚀 PRO-TRACKER: Order matching to dynamic Restaurant UUID = $realRestaurantId");

      // 3. Create Order Record in 'orders' table
      final orderData = {
        'restaurant_id': realRestaurantId, // ✅ Sahi restaurant ko hit karega
        'user_id': userId,
        'total_amount': widget.total.toString(), // String safe injection
        'status': 'pending',
        'address': widget.deliveryAddress.isNotEmpty ? widget.deliveryAddress : 'Default Address',
        'payment_method': selectedMethod,
        'cash_received': selectedMethod == 'Cash on Delivery' || selectedMethod == 'Cash',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final orderResponse = await supabase.from('orders').insert(orderData).select('id').single();
      final String orderId = orderResponse['id'] as String;

      // 4. Create Order Items safely
      final List<Map<String, dynamic>> itemsToInsert = [];
      for (var item in cartItems) {
        final double itemPrice = double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

        // Agar dynamic uuid format fail ho tou verification handle hogi
        final String prodId = _isValidUuid(item.id) ? item.id : item.id;

        itemsToInsert.add({
          'order_id': orderId,
          'product_id': prodId,
          'quantity': item.quantity,
          'price': itemPrice,
        });
      }

      if (itemsToInsert.isNotEmpty) {
        await supabase.from('order_items').insert(itemsToInsert);
      }

      // 5. Create Payment Log Record
      final paymentData = {
        'order_id': orderId,
        'amount': widget.total,
        'method': selectedMethod,
        'status': 'paid',
        'transaction_id': 'TXN-${DateTime.now().millisecondsSinceEpoch}',
        'paid_at': DateTime.now().toIso8601String(),
      };

      await supabase.from('payments').insert(paymentData);

      // 6. CLEAR CART SYSTEM: Success hote hi global cart ko clear karein
      cartItems.clear();
      print("🎉 PRO-TRACKER: Order complete! Cart flushed successfully.");

      // 7. Route Handling safely
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OrderSuccessScreen(),
          ),
        );
      }
    } catch (e) {
      print("❌ Error placing order: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to place order: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSavingOrder = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            backgroundColor: AppColor.backgroundYellow,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: context.rH(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: _circleBtn(Icons.arrow_back),
                ),
                const Text("Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(color: Colors.white, height: 35, width: 35, child: const Icon(Icons.person)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                top: -490,
                right: -95,
                child: BackgroundCircle(size: 600, color: AppColor.backgroundYellow),
              ),
              Positioned.fill(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  children: [
                    const SizedBox(height: 20),
                    _buildSectionTitle("Credit Cards", showAdd: true),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardList.length,
                        itemBuilder: (context, index) => _cardWidget(cardList[index]),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildSectionTitle("Other option"),
                    const SizedBox(height: 15),
                    ...optionList.map((opt) => _optionWidget(opt)).toList(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: widget.isFromCheckout
              ? Container(
            padding: EdgeInsets.fromLTRB(context.rW(4), context.rH(1.5), context.rW(4), context.rH(3.5)),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _placeOrderAndPay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.backgroundBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pay with $selectedMethod",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          )
              : null,
        ),
        if (_isSavingOrder)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColor.backgroundBlue),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Processing Order & Payment...",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, decoration: TextDecoration.none, color: Colors.black87),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Please do not close the app",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _cardWidget(CreditCardModel card) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 320,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: card.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: -25,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
            ),
            Positioned(
              bottom: 20,
              right: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.brand,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    card.cardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.holderName,
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      const Icon(Icons.contactless, color: Colors.white, size: 24),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionWidget(PaymentOptionModel opt) {
    bool isSelected = selectedMethod == opt.title;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = opt.title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? const Color(0xFFF5A623) : Colors.transparent),
        ),
        child: ListTile(
          leading: Icon(opt.icon, size: 30, color: Colors.blueGrey),
          title: Text(opt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Text(opt.balance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: Radio<String>(
            value: opt.title,
            groupValue: selectedMethod,
            activeColor: const Color(0xFFF5A623),
            onChanged: (v) => setState(() => selectedMethod = v!),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showAdd = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          if (showAdd)
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: CircleAvatar(
                backgroundColor: AppColor.backgroundBlue,
                child: const Icon(Icons.add, color: Colors.white, size: 35),
              ),
            ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: Colors.black),
    );
  }
}