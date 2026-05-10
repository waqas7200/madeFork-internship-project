// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
//
// class RecommendationCard extends StatelessWidget {
//   final Map<String, String> item;
//   final double cardWidth;
//
//   const RecommendationCard({super.key, required this.item, required this.cardWidth});
//
//   @override
//   Widget build(BuildContext context) {
//     final imgH = context.rH(13).clamp(90.0, 130.0);
//     final btnH = context.rH(3.8).clamp(28.0, 42.0);
//
//     return Container(
//       width: cardWidth,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(context.rW(3.5)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(context.rW(3.5)),
//             ),
//             child: Image.network(
//               item['image']!,
//               height: imgH,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) =>
//                   Container(height: imgH, color: Colors.grey.shade200),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(context.rW(2)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item['name']!,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: context.fs(3.2, min: 11, max: 15),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   item['store']!,
//                   style: TextStyle(
//                     fontSize: context.fs(2.7, min: 10, max: 13),
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//                 SizedBox(height: context.rH(0.5)),
//                 Text(
//                   item['price']!,
//                   style: TextStyle(
//                     color: const Color(0xFFE53935),
//                     fontWeight: FontWeight.w700,
//                     fontSize: context.fs(3.2, min: 11, max: 15),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Add to cart
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               context.rW(2), 0, context.rW(2), context.rW(2),
//             ),
//             child: SizedBox(
//               width: double.infinity,
//               height: btnH,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: Icon(Icons.add, size: context.rW(3.5).clamp(12, 18)),
//                 label: Text(
//                   'Add to cart',
//                   style: TextStyle(fontSize: context.fs(2.7, min: 10, max: 13)),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00897B),
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(context.rW(2)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// ─────────────────────────────────────────────
//  RECOMMENDATION CARD WITH HERO ANIMATION
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
import '../../screens/homeScreen/comandationscreen/productdetailscreen/productdetilscreen.dart';


class RecommendationCard extends StatelessWidget {
  final Product item;
  final double cardWidth;

  const RecommendationCard({
    super.key,
    required this.item,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    final imgH = context.rH(13).clamp(90.0, 130.0);
    final btnH = context.rH(3.8).clamp(28.0, 42.0);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: item),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.rW(3.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Hero Animation
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: item),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(context.rW(3.5)),
                ),
                child: Hero(
                  tag: 'product-${item.id}',
                  child: Image.network(
                    item.image,
                    height: imgH,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: imgH, color: Colors.grey.shade200),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.rW(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: context.fs(3.2, min: 11, max: 15),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.store,
                    style: TextStyle(
                      fontSize: context.fs(2.7, min: 10, max: 13),
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: context.rH(0.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.price,
                        style: TextStyle(
                          color: const Color(0xFFE53935),
                          fontWeight: FontWeight.w700,
                          fontSize: context.fs(3.2, min: 11, max: 15),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: const Color(0xFFFFA500),
                            size: context.rW(3),
                          ),
                          Text(
                            item.rating.toString(),
                            style: TextStyle(
                              fontSize: context.fs(2.5, min: 9, max: 12),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add to cart button
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.rW(2),
                0,
                context.rW(2),
                context.rW(2),
              ),
              child: SizedBox(
                width: double.infinity,
                height: btnH,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} کارٹ میں شامل ہوگی'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, size: context.rW(3.5).clamp(12, 18)),
                  label: Text(
                    'Add to cart',
                    style:
                    TextStyle(fontSize: context.fs(2.7, min: 10, max: 13)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.rW(2)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}