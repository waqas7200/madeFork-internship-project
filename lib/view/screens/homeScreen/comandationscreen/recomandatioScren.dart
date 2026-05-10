// //
// // // ─────────────────────────────────────────────
// // //  RECOMMENDATION LIST
// // // ─────────────────────────────────────────────
// // import 'package:flutter/cupertino.dart';
// //
// // import '../../../component/customRecomandation/customRcomandaion.dart';
// // import '../../bottomNavigationBar/bottomNavgationBar.dart';
// //
// // class RecommendationList extends StatelessWidget {
// //   const RecommendationList({super.key});
// //
// //   static const List<Map<String, String>> _items = [
// //     {
// //       'name': 'Kiwi Shake II',
// //       'store': "McDonald's",
// //       'price': '₱98.00',
// //       'image': 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=300',
// //     },
// //     {
// //       'name': 'Blueberry Maze',
// //       'store': "McDonald's",
// //       'price': '₱98.00',
// //       'image': 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=300',
// //     },
// //     {
// //       'name': 'Pats Burger',
// //       'store': "Starbucks",
// //       'price': '₱134.00',
// //       'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
// //     },
// //     {
// //       'name': 'Berries Yogurt',
// //       'store': "McDonald's",
// //       'price': '₱98.00',
// //       'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=300',
// //     },
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final cardW = context.rW(36).clamp(130.0, 180.0);
// //     final cardH = context.rH(26).clamp(190.0, 240.0);
// //     return SizedBox(
// //       height: cardH,
// //       child: ListView.separated(
// //       //  scrollDirection: Axis.horizontal,
// //
// //         padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
// //         itemCount: _items.length,
// //         separatorBuilder: (_, __) => SizedBox(width: context.rW(3)),
// //         itemBuilder: (context, i) =>
// //             RecommendationCard(item: _items[i], cardWidth: cardW),
// //       ),
// //     );
// //   }
// // }
// //
//
//
// // ─────────────────────────────────────────────
// //  RECOMMENDATION LIST
// // ─────────────────────────────────────────────
// import 'package:flutter/cupertino.dart';
// import '../../../component/customRecomandation/customRcomandaion.dart';
// import '../../bottomNavigationBar/bottomNavgationBar.dart';
//
// class RecommendationList extends StatelessWidget {
//   const RecommendationList({super.key});
//
//   static const List<Map<String, String>> _items = [
//     {
//       'name': 'Kiwi Shake II',
//       'store': "McDonald's",
//       'price': '₱98.00',
//       'image': 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=300',
//     },
//     {
//       'name': 'Blueberry Maze',
//       'store': "McDonald's",
//       'price': '₱98.00',
//       'image': 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=300',
//     },
//     {
//       'name': 'Pats Burger',
//       'store': "Starbucks",
//       'price': '₱134.00',
//       'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
//     },
//     {
//       'name': 'Berries Yogurt',
//       'store': "McDonald's",
//       'price': '₱98.00',
//       'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=300',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // Card width ko grid ke mutabiq adjust kiya gaya hai
//     final cardW = (MediaQuery.of(context).size.width / 2) - context.rW(6);
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(), // Agar parent list scrollable hai
//       padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
//       itemCount: _items.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, // Ek line mein 2 cards
//         crossAxisSpacing: context.rW(3), // Horizontal gap
//         mainAxisSpacing: context.rH(2),    // Vertical gap
//         childAspectRatio: 0.75,           // Card ki height/width adjust karne ke liye
//       ),
//       itemBuilder: (context, i) =>
//           RecommendationCard(item: _items[i], cardWidth: cardW),
//     );
//   }
// }


// ─────────────────────────────────────────────
//  RECOMMENDATION LIST - GRID VIEW
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../../component/customRecomandation/customRcomandaion.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Product.sampleProducts;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // ایک لائن میں 2 کارڈز
        crossAxisSpacing: context.rW(3), // افقی فاصلہ
        mainAxisSpacing: context.rH(2), // عمودی فاصلہ
        childAspectRatio: 0.75, // کارڈ کی اونائی/چوڑائی
      ),
      itemBuilder: (context, index) {
        final cardW =
            (MediaQuery.of(context).size.width / 2) - context.rW(6);
        return RecommendationCard(
          item: products[index],
          cardWidth: cardW,
        );
      },
    );
  }
}