//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
//
// class NearbyCard extends StatelessWidget {
//   final Map<String, String> item;
//
//   const NearbyCard({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     final avatarR = context.rW(8).clamp(26.0, 40.0);
//
//     return Container(
//       padding: EdgeInsets.all(context.rW(2.5)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(context.rW(3.5)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Circle avatar
//           CircleAvatar(
//             radius: avatarR,
//             backgroundImage: NetworkImage(item['image']!),
//             onBackgroundImageError: (_, __) {},
//           ),
//           SizedBox(width: context.rW(3)),
//           // Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       child: Text(
//                         item['name']!,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: context.fs(3.5, min: 12, max: 17),
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(width: context.rW(1)),
//                     Icon(Icons.verified,
//                         color: const Color(0xFF00897B),
//                         size: context.rW(3.5).clamp(12, 18)),
//                   ],
//                 ),
//                 SizedBox(height: context.rH(0.3)),
//                 Text(
//                   item['address']!,
//                   style: TextStyle(
//                     fontSize: context.fs(2.7, min: 10, max: 13),
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//                 SizedBox(height: context.rH(0.5)),
//                 Row(
//                   children: [
//                     Icon(Icons.star,
//                         color: Colors.amber,
//                         size: context.rW(3.2).clamp(11, 16)),
//                     SizedBox(width: context.rW(0.8)),
//                     Text(
//                       item['rating']!,
//                       style: TextStyle(
//                         fontSize: context.fs(2.8, min: 10, max: 14),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(width: context.rW(2)),
//                     Icon(Icons.location_on_outlined,
//                         size: context.rW(3.2).clamp(11, 16),
//                         color: Colors.grey),
//                     SizedBox(width: context.rW(0.8)),
//                     Text(
//                       item['distance']!,
//                       style: TextStyle(
//                         fontSize: context.fs(2.7, min: 10, max: 13),
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Distance badge
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: context.rW(2.5),
//               vertical: context.rH(0.8),
//             ),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00897B).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(context.rW(5)),
//             ),
//             child: Text(
//               item['distance']!,
//               style: TextStyle(
//                 color: const Color(0xFF00897B),
//                 fontSize: context.fs(2.7, min: 10, max: 13),
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/nerabyresturentModel/nearbyresturntModl.dart';
import '../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
import '../../screens/homeScreen/comandationscreen/productdetailscreen/productdetilscreen.dart';
import 'package:madeforke_app/utils/app_routes.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';

class NearbyCard extends StatelessWidget {
  final Map<String, String> item;
  final RestaurantModel? restaurant;

  const NearbyCard({super.key, required this.item, this.restaurant});

  @override
  Widget build(BuildContext context) {
    final avatarR = context.rW(8).clamp(26.0, 40.0);

    return GestureDetector(
      onTap: () {
        if (restaurant != null) {
          Get.toNamed(AppRoutes.restaurantDetail, arguments: restaurant);
        }
      },
      child: Container(
        padding: EdgeInsets.all(context.rW(2.5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.rW(3.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // ─── baaki sab same rahega ───
        child: Row(
          children: [
            CircleAvatar(
              radius: avatarR,
              backgroundImage: NetworkImage(item['image']!),
              onBackgroundImageError: (_, __) {},
            ),
            SizedBox(width: context.rW(3)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: APPResponsive.fs(3.5, min: 12, max: 17),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: context.rW(1)),
                      Icon(
                        Icons.verified,
                        color: const Color(0xFF00897B),
                        size: context.rW(3.5).clamp(12, 18),
                      ),
                    ],
                  ),
                  SizedBox(height: context.rH(0.3)),
                  Text(
                    item['address']!,
                    style: TextStyle(
                      fontSize: APPResponsive.fs(2.7, min: 10, max: 13),
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: context.rH(0.5)),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: context.rW(3.2).clamp(11, 16),
                      ),
                      SizedBox(width: context.rW(0.8)),
                      Text(
                        item['rating']!,
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.8, min: 10, max: 14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: context.rW(2)),
                      Icon(
                        Icons.location_on_outlined,
                        size: context.rW(3.2).clamp(11, 16),
                        color: Colors.grey,
                      ),
                      SizedBox(width: context.rW(0.8)),
                      Text(
                        item['distance']!,
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.7, min: 10, max: 13),
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.rW(2.5),
                vertical: context.rH(0.8),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF00897B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.rW(5)),
              ),
              child: Text(
                item['distance']!,
                style: TextStyle(
                  color: const Color(0xFF00897B),
                  fontSize: APPResponsive.fs(2.7, min: 10, max: 13),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
