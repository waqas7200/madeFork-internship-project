import 'package:flutter/material.dart';

import '../../../model/oderhistory/ordderhistory.dart';
import '../../component/customCircleAvator/customCircleavators.dart';
import '../../utils/costsColors/constColors.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';
import '../homeScreen/myorderScreenCart/myOrderCart.dart';
import '../homeScreen/searchbar/sarhbar.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // 🔹 Dummy API-like data
  final List<Map<String, dynamic>> rawOrders = [
    {
      "name": "Classic Milk Tea",
      "date": "May 1, 2026",
      "price": "\$3.50",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Taro Milk Tea",
      "date": "Apr 28, 2026",
      "price": "\$4.00",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
    {
      "name": "Matcha Milk Tea",
      "date": "Apr 25, 2026",
      "price": "\$4.20",
      "image": "assets/splash_Icon/img.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateCartCount();
  }
  int _totalCartItems = 0;
  void _updateCartCount() {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity;
    }
    setState(() {
      _totalCartItems = total;
    });
  }

  // 🔹 Convert Map → Model
  List<OrderItem> get orders =>
      rawOrders.map((e) => OrderItem.fromMap(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: context.rH(10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore the taste',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: APPResponsive.fs(3.2, min: 11, max: 15),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'of Asian Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: APPResponsive.fs(4.5, min: 15, max: 22),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // ✅ CART ICON WITH BADGE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrderScreen()),
                    ).then((_) {
                      _updateCartCount();
                    });
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: context.rW(6).clamp(18, 26),
                        backgroundColor: AppColor.backgroundBlue,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColor.backgroundYellow,
                          size: context.rW(6).clamp(20, 30),
                        ),
                      ),
                      if (_totalCartItems > 0)
                        Positioned(
                          right: -6,
                          top: -6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 22,
                              minHeight: 22,
                            ),
                            child: Text(
                              '$_totalCartItems',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: context.rW(3)),
                CircleAvatar(
                  radius: context.rW(5).clamp(18, 26),
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=47',
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [],
      ),

      body: Stack(
        children: [
          // --- Background Circles (Same as Home) ---

          SizedBox(
            height: context.rH(10),
            width: context.rW(4),
          ),
          Positioned(
            // Height aur Width ka hisab laga kar negative offset set kiya hai
            top:-345,
            //-context.rH(45),
            left: -context.rW(4),
            child: Transform.rotate(
              angle: -0,
              child: Container(
                // Screen ki width ke mutabiq size adjust hoga
                width: context.rW(110),
                height: context.rW(120),
                decoration: BoxDecoration(
                  color: AppColor.backgroundYellow,
                  // Curve ko bhi responsive rakha hai
                  borderRadius: BorderRadius.circular(context.rW(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: context.rH(10),
                width: context.rW(4),
              ),
              const SearchBarWidget(),

              Expanded(
                child: Container(
                 // margin: const EdgeInsets.symmetric(horizontal: 16),
                 // padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: orders.length,
                    // separatorBuilder: (_, __) =>
                        // Divider(color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      return Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              order.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(order.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(order.date,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12)),
                          trailing: Text(order.price,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              color: AppColor.backgroundYellow)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),



     
    );
  }

  Widget navItem(IconData icon, bool isActive) {
    return Icon(
      icon,
      color: isActive ? const Color(0xFFFFC107) : Colors.grey,
    );
  }
}