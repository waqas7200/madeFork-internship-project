// import 'package:flutter/material.dart';
//
// import '../../../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
// import '../../../../../component/customSnackbar/customSnakbar.dart';
// import '../../../../bottomNavigationBar/bottomNavgationBar.dart';
//
// class FavoriteScreen extends StatefulWidget {
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//
//
// // ✅ یہ global list ہے - تمام screens اسے access کر سکتے ہیں
//   List<Product> favoriteItems = [];
//
//   void addToFavorite(Product product) {
//     if (!favoriteItems.any((item) => item.id == product.id)) {
//       product.isFavorite = true;
//       favoriteItems.add(product);
//     }
//   }
//
//   void removeFromFavorite(Product product) {
//     product.isFavorite = false;
//     favoriteItems.removeWhere((item) => item.id == product.id);
//   }
//
//   bool isFavorite(String productId) {
//     return favoriteItems.any((item) => item.id == productId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Favorite")),
//
//       body: favoriteItems.isEmpty
//           ? Center(child: Text("No favorites yet"))
//           : ListView.builder(
//         itemCount: favoriteItems.length,
//         itemBuilder: (context, index) {
//           final item = favoriteItems[index];
//
//           return Container(
//             margin: EdgeInsets.all(10),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(color: Colors.black12, blurRadius: 5)
//               ],
//             ),
//             child: Row(
//               children: [
//                 Image.network(item.image,
//                     width: 60, height: 60),
//
//                 SizedBox(width: 10),
//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                     children: [
//                       Text(item.name,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold)),
//                       Text(item.price,
//                           style: TextStyle(
//                               color: Colors.green)),
//                     ],
//                   ),
//                 ),
//
//                 IconButton(
//                   icon: Icon(Icons.favorite,
//                       color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       item.isFavorite = false;
//                       favoriteItems.removeAt(index);
//                     });
//                   },
//                 ),
//                 // ✅ FAVORITE BUTTON - setState کے ساتھ
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       if (_currentProduct.isFavorite) {
//                         removeFromFavorite(_currentProduct);
//                         CustomSnackBar.show(
//                           context,
//                           'Removed from favorites',
//                         );
//                       } else {
//                         addToFavorite(_currentProduct);
//                         CustomSnackBar.show(
//                           context,
//                           'Added to favorites',
//                         );
//                       }
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.rW(3),
//                       vertical: context.rH(1.2),
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFF0F5),
//                       borderRadius: BorderRadius.circular(context.rW(2.5)),
//                     ),
//                     child: Icon(
//                       _currentProduct.isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       color: Colors.red,
//                       size: context.rW(5.5),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';

import '../../../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';

// ✅ یہ وہی global list ہے جو ProductDetailScreen میں بھی ہے
List<Product> globalFavoriteItems = [];

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites (${globalFavoriteItems.length})"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: globalFavoriteItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No favorites yet",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Add items to your favorites",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: globalFavoriteItems.length,
              itemBuilder: (context, index) {
                final item = globalFavoriteItems[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // ✅ Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),

                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Text(
                              item.store,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item.price,
                              style: TextStyle(
                                color: Color(0xFFE53935),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ Remove Button - setState کے ساتھ
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red, size: 24),
                        onPressed: () {
                          setState(() {
                            // Global list سے remove کریں
                            item.isFavorite = false;
                            globalFavoriteItems.removeAt(index);
                          });

                          // SnackBar دکھائیں
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item.name} removed from favorites',
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red.shade400,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
