//
//
// import 'package:flutter/material.dart';
//
// import '../../../../../model/addtocartmodel/addtocarmodel.dart';
// import '../../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
// import '../../../../../model/restaurantProductModel/restaurant_product_model.dart';
// import '../../../../component/customSnackbar/customSnakbar.dart';
// import '../../../../utils/costsColors/constColors.dart';
// import '../../../../utils/responsiveClass/responosiveC;ass.dart';
// import '../../../bottomNavigationBar/bottomNavgationBar.dart';
// import '../../../filterscrren/filtrscreen.dart';
// import '../../myorderScreenCart/myOrderCart.dart';
// import 'favoritescreen/flyingAnimationScreenflyningAnimationcreen.dart';
//
// // ✅ Global favorites list
// List<Product> globalFavoriteItems = [];
//
// class ProductDetailScreen extends StatefulWidget {
//   final Product product;
//
//   const ProductDetailScreen({super.key, required this.product});
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Product _currentProduct;
//   String? selectedSize;
//   int quantity = 1;
//   final GlobalKey _imageKey = GlobalKey();
//   final GlobalKey _cartKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     _currentProduct = widget.product;
//     if (_currentProduct.sizes.isEmpty) {
//       selectedSize = 'M';
//     } else {
//       selectedSize = _currentProduct.sizes.first;
//     }
//   }
//
//   void _runFlyAnimation() {
//     final RenderBox? imageBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
//     final RenderBox? cartBox = _cartKey.currentContext?.findRenderObject() as RenderBox?;
//
//     if (imageBox == null || cartBox == null) return;
//
//     final Offset startOffset = imageBox.localToGlobal(Offset.zero);
//     final Offset endOffset = cartBox.localToGlobal(Offset.zero);
//
//     late OverlayEntry overlayEntry;
//     overlayEntry = OverlayEntry(
//       builder: (context) => FlyAnimationWidget(
//         startOffset: startOffset,
//         endOffset: endOffset,
//         imageUrl: _currentProduct.image,
//         onComplete: () {
//           overlayEntry.remove();
//           addToCart;
//           Future.delayed(const Duration(milliseconds: 300), () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyOrderScreen()),
//             );
//           });
//         },
//       ),
//     );
//
//     Overlay.of(context).insert(overlayEntry);
//   }
//
//   // void _addToCart() {
//   //   final existingIndex = cartItems.indexWhere(
//   //         (item) => item.id == _currentProduct.id && item.size == selectedSize,
//   //   );
//   //
//   //   if (existingIndex >= 0) {
//   //     cartItems[existingIndex].quantity += quantity;
//   //   } else {
//   //     cartItems.add(
//   //       CartItem(
//   //         id: _currentProduct.id,
//   //         name: _currentProduct.name,
//   //         price: _currentProduct.price,
//   //         image: _currentProduct.image,
//   //         size: selectedSize ?? 'N/A',
//   //         quantity: quantity,
//   //       ),
//   //     );
//   //   }
//   //
//   //   setState(() {
//   //     quantity = 1;
//   //   });
//   // }
//
//   // ── ADD TO CART BUTTON CLICK CODE ──
//   void addToCart(RestaurantProductModel product, String selectedSize, int quantity) {
//
//     // Pehle check karein agar cart khali nahi hai aur kisi doosre resturent ka item add ho raha hai
//     if (cartItems.isNotEmpty && cartItems.first.restaurantId != product.restaurantId) {
//       // Aap yahan user ko alert bhi dikha sakte hain ke "You can only order from one restaurant at a time"
//       print("Alert: Doosre restaurant ka item add nahi ho sakta!");
//     }
//
//     final newItem = CartItem(
//       id: product.id,
//       name: product.title,
//       price: product.total.toString(), // Price pass ho rahi hai
//       image: product.image,
//       size: selectedSize.isEmpty ? 'Standard' : selectedSize,
//       restaurantId: product.restaurantId, // ✅ Real dynamic ID product model se ja rahi hai
//       quantity: quantity,
//     );
//
//     // Cart list mein save karlein
//     cartItems.add(newItem);
//     print("✅ Item added to cart with Restaurant ID: ${product.restaurantId}");
//   }
//
//   // ✅ Favorite add/remove function
//   void _toggleFavorite() {
//     setState(() {
//       if (_currentProduct.isFavorite) {
//         // Remove سے favorite
//         _currentProduct.isFavorite = false;
//         globalFavoriteItems.removeWhere((item) => item.id == _currentProduct.id);
//         CustomSnackBar.show(
//           context,
//           'Removed from favorites',
//         );
//       } else {
//         // Add کریں favorite میں
//         _currentProduct.isFavorite = true;
//         globalFavoriteItems.add(_currentProduct);
//         CustomSnackBar.show(
//           context,
//           'Added to favorites',
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final statusBarHeight = MediaQuery.of(context).padding.top;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   const Color(0xFFE8F5F0),
//                   Colors.white,
//                 ],
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Hero Image Section
//                 Container(
//                   key: _imageKey,
//                   height: MediaQuery.of(context).size.height * 0.38,
//                   width: double.infinity,
//                   child: Hero(
//                     tag: 'product-${_currentProduct.id}',
//                     child: Image.network(
//                       _currentProduct.image,
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         color: Colors.grey.shade200,
//                         child: Icon(
//                           Icons.image_not_supported,
//                           size: context.rW(10),
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Product Details Container
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(context.rW(6)),
//                       topRight: Radius.circular(context.rW(6)),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 15,
//                         offset: const Offset(0, -5),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(context.rW(4)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title اور Store
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     _currentProduct.name,
//                                     style: TextStyle(
//                                       fontSize: APPResponsive.fs(5, min: 18, max: 24),
//                                       fontWeight: FontWeight.w800,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   SizedBox(height: context.rH(0.8)),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: context.rW(2.5),
//                                       vertical: context.rH(0.5),
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFF0F8F6),
//                                       borderRadius:
//                                       BorderRadius.circular(context.rW(2)),
//                                     ),
//                                     child: Text(
//                                       _currentProduct.store,
//                                       style: TextStyle(
//                                         fontSize:
//                                         APPResponsive.fs(2.8, min: 10, max: 13),
//                                         color: const Color(0xFF00897B),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: context.rW(2)),
//                             Stack(
//                               key: _cartKey,
//                               clipBehavior: Clip.none,
//                               children: [
//                                 _buildCircleBtn(Icons.shopping_cart_outlined, () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => MyOrderScreen()),
//                                   );
//                                 }),
//                               ],
//                             ),
//                             SizedBox(width: context.rW(2)),
//                             // ✅ FAVORITE BUTTON - setState کے ساتھ
//                             GestureDetector(
//                               onTap: _toggleFavorite,
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: context.rW(3),
//                                   vertical: context.rH(1.2),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFFFF0F5),
//                                   borderRadius: BorderRadius.circular(
//                                       context.rW(2.5)),
//                                 ),
//                                 child: Icon(
//                                   _currentProduct.isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: Colors.red,
//                                   size: context.rW(5.5),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.rH(2)),
//
//                         // Price
//                         Row(
//                           children: [
//                             Text(
//                               _currentProduct.price,
//                               style: TextStyle(
//                                 fontSize: APPResponsive.fs(6, min: 22, max: 30),
//                                 fontWeight: FontWeight.w900,
//                                 color: const Color(0xFFE53935),
//                               ),
//                             ),
//                             SizedBox(width: context.rW(2)),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: context.rW(2),
//                                 vertical: context.rH(0.5),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFEBEE),
//                                 borderRadius:
//                                 BorderRadius.circular(context.rW(1.5)),
//                               ),
//                               child: Text(
//                                 'Special',
//                                 style: TextStyle(
//                                   fontSize: APPResponsive.fs(2.2, min: 8, max: 10),
//                                   color: const Color(0xFFE53935),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.rH(1.5)),
//
//                         // Rating
//                         Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: context.rW(2.5),
//                                 vertical: context.rH(0.6),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFA500),
//                                 borderRadius:
//                                 BorderRadius.circular(context.rW(2)),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.star_rounded,
//                                     color: Colors.white,
//                                     size: context.rW(3.5),
//                                   ),
//                                   SizedBox(width: context.rW(0.8)),
//                                   Text(
//                                     _currentProduct.rating.toString(),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize:
//                                       APPResponsive.fs(2.8, min: 10, max: 13),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: context.rW(2)),
//                             Text(
//                               '(${_currentProduct.reviews} reviews)',
//                               style: TextStyle(
//                                 fontSize: APPResponsive.fs(2.8, min: 10, max: 13),
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.rH(2.5)),
//
//                         Container(
//                           height: 1,
//                           color: Colors.grey.shade200,
//                         ),
//                         SizedBox(height: context.rH(2.5)),
//
//                         // Size Selection
//                         Text(
//                           'Size',
//                           style: TextStyle(
//                             fontSize: APPResponsive.fs(3.5, min: 12, max: 16),
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: context.rH(1.5)),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: List.generate(
//                               _currentProduct.sizes.isNotEmpty
//                                   ? _currentProduct.sizes.length
//                                   : 4,
//                                   (index) {
//                                 final sizes = _currentProduct.sizes.isNotEmpty
//                                     ? _currentProduct.sizes
//                                     : ['S', 'M', 'L', 'XL'];
//                                 final size = sizes[index];
//                                 final isSelected = selectedSize == size;
//                                 return Padding(
//                                   padding: EdgeInsets.only(right: context.rW(2)),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         selectedSize = size;
//                                       });
//                                     },
//                                     child: AnimatedContainer(
//                                       duration:
//                                       const Duration(milliseconds: 300),
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: context.rW(4),
//                                         vertical: context.rH(1.5),
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? const Color(0xFF00897B)
//                                             : Colors.grey.shade100,
//                                         borderRadius: BorderRadius.circular(
//                                             context.rW(2.5)),
//                                         border: isSelected
//                                             ? Border.all(
//                                           color: const Color(0xFF00897B),
//                                           width: 2,
//                                         )
//                                             : Border.all(
//                                           color: Colors.grey.shade300,
//                                           width: 1,
//                                         ),
//                                         boxShadow: isSelected
//                                             ? [
//                                           BoxShadow(
//                                             color: const Color(0xFF00897B)
//                                                 .withOpacity(0.3),
//                                             blurRadius: 8,
//                                             offset: const Offset(0, 4),
//                                           )
//                                         ]
//                                             : [],
//                                       ),
//                                       child: Text(
//                                         size,
//                                         style: TextStyle(
//                                           fontSize:
//                                           APPResponsive.fs(3, min: 11, max: 14),
//                                           fontWeight: FontWeight.w700,
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors.grey.shade700,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: context.rH(2.5)),
//
//                         Container(
//                           height: 1,
//                           color: Colors.grey.shade200,
//                         ),
//                         SizedBox(height: context.rH(2.5)),
//
//                         // Description
//                         Text(
//                           'Description',
//                           style: TextStyle(
//                             fontSize: APPResponsive.fs(3.5, min: 12, max: 16),
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: context.rH(1)),
//                         Text(
//                           _currentProduct.description,
//                           style: TextStyle(
//                             fontSize: APPResponsive.fs(3, min: 11, max: 14),
//                             color: Colors.grey.shade600,
//                             height: 1.8,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(height: context.rH(3)),
//
//                         // Quantity اور Add to Cart
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF0F8F6),
//                             borderRadius:
//                             BorderRadius.circular(context.rW(3)),
//                           ),
//                           padding: EdgeInsets.all(context.rW(3)),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     'items :',
//                                     style: TextStyle(
//                                       fontSize:
//                                       APPResponsive.fs(3.2, min: 11, max: 14),
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: AppColor.backgroundBlue,
//                                       border: Border.all(
//                                           color: AppColor.backgroundBlue),
//                                       borderRadius:
//                                       BorderRadius.circular(context.rW(2)),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             if (quantity > 1) {
//                                               setState(() => quantity--);
//                                             }
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: context.rW(2.5),
//                                               vertical: context.rH(0.8),
//                                             ),
//                                             child: Icon(
//                                               Icons.remove_rounded,
//                                               color: Colors.white,
//                                               size: context.rW(4.5),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: context.rW(3.5),
//                                           ),
//                                           child: Text(
//                                             quantity.toString(),
//                                             style: TextStyle(
//                                               fontSize: APPResponsive.fs(3.5,
//                                                   min: 13, max: 16),
//                                               fontWeight: FontWeight.w800,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             setState(() => quantity++);
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: context.rW(2.5),
//                                               vertical: context.rH(0.8),
//                                             ),
//                                             child: Icon(
//                                               Icons.add_rounded,
//                                               color: Colors.white,
//                                               size: context.rW(4.5),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: context.rH(2)),
//
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: context.rH(5.8),
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     _runFlyAnimation();
//                                     CustomSnackBar.show(
//                                       context,
//                                       '$quantity × ${_currentProduct.name} (${selectedSize ?? 'size'}) added to cart',
//                                     );
//                                   },
//                                   icon: Icon(
//                                     Icons.shopping_cart_rounded,
//                                     size: context.rW(5.5),
//                                   ),
//                                   label: Text(
//                                     'Add to Cart',
//                                     style: TextStyle(
//                                       fontSize:
//                                       APPResponsive.fs(3.3, min: 12, max: 15),
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                     const Color(0xFF00897B),
//                                     foregroundColor: Colors.white,
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           context.rW(2.5)),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: context.rH(2)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Back Button
//           Positioned(
//             top: MediaQuery.of(context).padding.top + context.rH(1.5),
//             left: context.rW(4),
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 padding: EdgeInsets.all(context.rW(2.5)),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.15),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: Colors.black87,
//                   size: context.rW(5.5),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCircleBtn(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(context.rW(2.5)),
//         decoration: const BoxDecoration(
//           color: const Color(0xFFFFF0F5),
//           shape: BoxShape.circle,
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//         ),
//         child: Icon(icon, color: Colors.black87, size: context.rW(5.5)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/addtocartmodel/addtocarmodel.dart';
import '../../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../../../../model/restaurantProductModel/restaurant_product_model.dart';
import '../../../../component/customSnackbar/customSnakbar.dart';
import 'package:madeforke_app/utils/app_routes.dart';
import '../../../../utils/costsColors/constColors.dart';
import '../../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../../bottomNavigationBar/bottomNavgationBar.dart';
import '../../../filterscrren/filtrscreen.dart';
import '../../myorderScreenCart/myOrderCart.dart';
import 'favoritescreen/flyingAnimationScreenflyningAnimationcreen.dart';

// ✅ Global favorites list
List<Product> globalFavoriteItems = [];

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _currentProduct;
  String? selectedSize;
  int quantity = 1;
  final GlobalKey _imageKey = GlobalKey();
  final GlobalKey _cartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
    if (_currentProduct.sizes.isEmpty) {
      selectedSize = 'M';
    } else {
      selectedSize = _currentProduct.sizes.first;
    }
  }

  void _runFlyAnimation() {
    final RenderBox? imageBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? cartBox =
        _cartKey.currentContext?.findRenderObject() as RenderBox?;

    if (imageBox == null || cartBox == null) return;

    final Offset startOffset = imageBox.localToGlobal(Offset.zero);
    final Offset endOffset = cartBox.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => FlyAnimationWidget(
        startOffset: startOffset,
        endOffset: endOffset,
        imageUrl: _currentProduct.image,
        onComplete: () {
          overlayEntry.remove();

          // ✅ FIX 1: Parenthesis lagakar parameters ke sath function execute kiya
          executeAddToCart(
            product: _currentProduct,
            selectedSize: selectedSize ?? 'Standard',
            quantity: quantity,
          );

          Future.delayed(const Duration(milliseconds: 300), () {
            Get.toNamed(AppRoutes.myOrder);
          });
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  // ── ✅ FIX 2: REFACTORED WORKABLE ADD TO CART ENGINE ──
  void executeAddToCart({
    required Product product,
    required String selectedSize,
    required int quantity,
  }) {
    // 1. Check karein agar cart empty nahi hai aur kisi doosre restaurant ka item add ho raha hai
    if (cartItems.isNotEmpty &&
        cartItems.first.restaurantId != product.restaurantId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Alert: You can only order from one restaurant at a time!",
          ),
          backgroundColor: Colors.orange,
        ),
      );
      print("Alert: Doosre restaurant ka item add nahi ho sakta!");
      return; // Execution block stop karne ke liye return lagaya
    }

    // 2. Check karein agar same product aur same size pehle se cart me hai
    final existingIndex = cartItems.indexWhere(
      (item) => item.id == product.id && item.size == selectedSize,
    );

    if (existingIndex >= 0) {
      // Pehle se item hone par sirf quantity barhayein
      cartItems[existingIndex].quantity += quantity;
      cartItems.refresh();
      print("✅ Existing product quantity updated in cart.");
    } else {
      // Currency string clean karne ke liye helper regex parser
      String cleanPrice = product.price.replaceAll(RegExp(r'[^0-9.]'), '');

      // Naya object map karke push chalayein
      final newItem = CartItem(
        id: product.id,
        name: product.name,
        price: cleanPrice.isEmpty ? product.price : cleanPrice,
        image: product.image,
        size: selectedSize.isEmpty ? 'Standard' : selectedSize,
        restaurantId:
            product.restaurantId ??
            '', // ✅ Link dynamic restaurant ID parameter
        quantity: quantity,
      );

      cartItems.add(newItem);
      print("✅ New item added with Restaurant ID: ${product.restaurantId}");
    }

    setState(() {
      this.quantity = 1; // Counter state default setting par revert ho jaye
    });
  }

  // ✅ Favorite add/remove function
  void _toggleFavorite() {
    setState(() {
      if (_currentProduct.isFavorite) {
        _currentProduct.isFavorite = false;
        globalFavoriteItems.removeWhere(
          (item) => item.id == _currentProduct.id,
        );
        CustomSnackBar.show(context, 'Removed from favorites');
      } else {
        _currentProduct.isFavorite = true;
        globalFavoriteItems.add(_currentProduct);
        CustomSnackBar.show(context, 'Added to favorites');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE8F5F0), Colors.white],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image Section
                Container(
                  key: _imageKey,
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: Hero(
                    tag: 'product-${_currentProduct.id}',
                    child: Image.network(
                      _currentProduct.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          size: context.rW(10),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Product Details Container
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.rW(6)),
                      topRight: Radius.circular(context.rW(6)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.rW(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title aur Store Layout
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentProduct.name,
                                    style: TextStyle(
                                      fontSize: APPResponsive.fs(
                                        5,
                                        min: 18,
                                        max: 24,
                                      ),
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: context.rH(0.8)),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.rW(2.5),
                                      vertical: context.rH(0.5),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0F8F6),
                                      borderRadius: BorderRadius.circular(
                                        context.rW(2),
                                      ),
                                    ),
                                    child: Text(
                                      _currentProduct.store,
                                      style: TextStyle(
                                        fontSize: APPResponsive.fs(
                                          2.8,
                                          min: 10,
                                          max: 13,
                                        ),
                                        color: const Color(0xFF00897B),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: context.rW(2)),
                            Stack(
                              key: _cartKey,
                              clipBehavior: Clip.none,
                              children: [
                                _buildCircleBtn(
                                  Icons.shopping_cart_outlined,
                                  () {
                                    Get.toNamed(AppRoutes.myOrder);
                                  },
                                ),
                                Obx(() {
                                  int total = 0;
                                  for (var item in cartItems) {
                                    total += item.quantity;
                                  }
                                  if (total == 0) return const SizedBox.shrink();
                                  return Positioned(
                                    right: -2,
                                    top: -2,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 20,
                                        minHeight: 20,
                                      ),
                                      child: Text(
                                        '$total',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(width: context.rW(2)),
                            GestureDetector(
                              onTap: _toggleFavorite,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.rW(3),
                                  vertical: context.rH(1.2),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF0F5),
                                  borderRadius: BorderRadius.circular(
                                    context.rW(2.5),
                                  ),
                                ),
                                child: Icon(
                                  _currentProduct.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: context.rW(5.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.rH(2)),

                        // Price
                        Row(
                          children: [
                            Text(
                              _currentProduct.price,
                              style: TextStyle(
                                fontSize: APPResponsive.fs(6, min: 22, max: 30),
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                            SizedBox(width: context.rW(2)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.rW(2),
                                vertical: context.rH(0.5),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(
                                  context.rW(1.5),
                                ),
                              ),
                              child: Text(
                                'Special',
                                style: TextStyle(
                                  fontSize: APPResponsive.fs(
                                    2.2,
                                    min: 8,
                                    max: 10,
                                  ),
                                  color: const Color(0xFFE53935),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.rH(1.5)),

                        // Rating
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.rW(2.5),
                                vertical: context.rH(0.6),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFA500),
                                borderRadius: BorderRadius.circular(
                                  context.rW(2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.white,
                                    size: context.rW(3.5),
                                  ),
                                  SizedBox(width: context.rW(0.8)),
                                  Text(
                                    _currentProduct.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: APPResponsive.fs(
                                        2.8,
                                        min: 10,
                                        max: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: context.rW(2)),
                            Text(
                              '(${_currentProduct.reviews} reviews)',
                              style: TextStyle(
                                fontSize: APPResponsive.fs(
                                  2.8,
                                  min: 10,
                                  max: 13,
                                ),
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.rH(2.5)),
                        Container(height: 1, color: Colors.grey.shade200),
                        SizedBox(height: context.rH(2.5)),

                        // Size Engine
                        Text(
                          'Size',
                          style: TextStyle(
                            fontSize: APPResponsive.fs(3.5, min: 12, max: 16),
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: context.rH(1.5)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _currentProduct.sizes.isNotEmpty
                                  ? _currentProduct.sizes.length
                                  : 4,
                              (index) {
                                final sizes = _currentProduct.sizes.isNotEmpty
                                    ? _currentProduct.sizes
                                    : ['S', 'M', 'L', 'XL'];
                                final size = sizes[index];
                                final isSelected = selectedSize == size;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: context.rW(2),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = size;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.rW(4),
                                        vertical: context.rH(1.5),
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF00897B)
                                            : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(
                                          context.rW(2.5),
                                        ),
                                        border: isSelected
                                            ? Border.all(
                                                color: const Color(0xFF00897B),
                                                width: 2,
                                              )
                                            : Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1,
                                              ),
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: const Color(
                                                    0xFF00897B,
                                                  ).withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontSize: APPResponsive.fs(
                                            3,
                                            min: 11,
                                            max: 14,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: context.rH(2.5)),
                        Container(height: 1, color: Colors.grey.shade200),
                        SizedBox(height: context.rH(2.5)),

                        // Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: APPResponsive.fs(3.5, min: 12, max: 16),
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: context.rH(1)),
                        Text(
                          _currentProduct.description,
                          style: TextStyle(
                            fontSize: APPResponsive.fs(3, min: 11, max: 14),
                            color: Colors.grey.shade600,
                            height: 1.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: context.rH(3)),

                        // Quantity Panel
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8F6),
                            borderRadius: BorderRadius.circular(context.rW(3)),
                          ),
                          padding: EdgeInsets.all(context.rW(3)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'items :',
                                    style: TextStyle(
                                      fontSize: APPResponsive.fs(
                                        3.2,
                                        min: 11,
                                        max: 14,
                                      ),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.backgroundBlue,
                                      border: Border.all(
                                        color: AppColor.backgroundBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        context.rW(2),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (quantity > 1) {
                                              setState(() => quantity--);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: context.rW(2.5),
                                              vertical: context.rH(0.8),
                                            ),
                                            child: Icon(
                                              Icons.remove_rounded,
                                              color: Colors.white,
                                              size: context.rW(4.5),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: context.rW(3.5),
                                          ),
                                          child: Text(
                                            quantity.toString(),
                                            style: TextStyle(
                                              fontSize: APPResponsive.fs(
                                                3.5,
                                                min: 13,
                                                max: 16,
                                              ),
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => quantity++);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: context.rW(2.5),
                                              vertical: context.rH(0.8),
                                            ),
                                            child: Icon(
                                              Icons.add_rounded,
                                              color: Colors.white,
                                              size: context.rW(4.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: context.rH(2)),
                              SizedBox(
                                width: double.infinity,
                                height: context.rH(5.8),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _runFlyAnimation();
                                    CustomSnackBar.show(
                                      context,
                                      '$quantity × ${_currentProduct.name} (${selectedSize ?? 'size'}) added to cart',
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_rounded,
                                    size: context.rW(5.5),
                                  ),
                                  label: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: APPResponsive.fs(
                                        3.3,
                                        min: 12,
                                        max: 15,
                                      ),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00897B),
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        context.rW(2.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.rH(2)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + context.rH(1.5),
            left: context.rW(4),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(context.rW(2.5)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87,
                  size: context.rW(5.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.rW(2.5)),
        decoration: const BoxDecoration(
          color: Color(0xFFFFF0F5),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Icon(icon, color: Colors.black87, size: context.rW(5.5)),
      ),
    );
  }
}
