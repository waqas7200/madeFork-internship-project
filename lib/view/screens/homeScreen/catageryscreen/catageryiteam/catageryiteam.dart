//
// // ─────────────────────────────────────────────
// //  CATEGORY MENU
// // ─────────────────────────────────────────────
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../component/catageruIteam/catageryIteam.dart';
// import '../../bottomNavigationBar/bottomNavgationBar.dart';
//
// class CategoryMenu extends StatelessWidget {
//   const CategoryMenu({super.key});
//
//   static const List<Map<String, dynamic>> _categories = [
//     {'icon': Icons.apple,        'label': 'Fruit',  'color': Color(0xFFE57373)},
//     {'icon': Icons.lunch_dining, 'label': 'Burger', 'color': Color(0xFFFF8A65)},
//     {'icon': Icons.icecream,     'label': 'Yogurt', 'color': Color(0xFFFFCA28)},
//     {'icon': Icons.cake,         'label': 'Cream',  'color': Color(0xFF64B5F6)},
//     {'icon': Icons.local_pizza,  'label': 'Pizza',  'color': Color(0xFF81C784)},
//     {'icon': Icons.coffee,       'label': 'Drinks', 'color': Color(0xFFA1887F)},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final itemSize = context.rW(14).clamp(50.0, 72.0);
//     return SizedBox(
//       height: itemSize + context.rH(4),
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
//         itemCount: _categories.length,
//         separatorBuilder: (_, __) => SizedBox(width: context.rW(3)),
//         itemBuilder: (context, i) {
//           final cat = _categories[i];
//           return CategoryItem(
//             icon: cat['icon'] as IconData,
//             label: cat['label'] as String,
//             color: cat['color'] as Color,
//             itemSize: itemSize,
//           );
//         },
//       ),
//     );
//   }
// }

// ─────────────────────────────────────────────
//  CATEGORY MENU
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
//  RESPONSIVE CATEGORY MENU
// ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madeforke_app/utils/app_routes.dart';
import '../../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../../bottomNavigationBar/bottomNavgationBar.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'icon': Icons.apple, 'label': 'Fruit', 'color': Color(0xFFE57373)},
    {'icon': Icons.lunch_dining, 'label': 'Burger', 'color': Color(0xFFFF8A65)},
    {'icon': Icons.icecream, 'label': 'Yogurt', 'color': Color(0xFFFFCA28)},
    {'icon': Icons.cake, 'label': 'Cream', 'color': Color(0xFF64B5F6)},
    {'icon': Icons.local_pizza, 'label': 'Pizza', 'color': Color(0xFF81C784)},
    {'icon': Icons.coffee, 'label': 'Drinks', 'color': Color(0xFFA1887F)},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Screen width ke hisab se item size calculate ho rahi hai
        final double itemWidth = (constraints.maxWidth * 0.22).clamp(
          85.0,
          110.0,
        );

        return SizedBox(
          // AspectRatio ensure karega ke card ki shape har device par sahi rahe
          height: itemWidth * 1.1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
            itemCount: _categories.length,
            itemBuilder: (context, i) {
              final cat = _categories[i];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.category);
                },
                child: Container(
                  width: itemWidth,
                  margin: EdgeInsets.only(
                    right: context.rW(3),
                    bottom: 5,
                    top: 5,
                  ),
                  child: Card(
                    elevation: 3,
                    shadowColor: (cat['color'] as Color).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Responsive Icon Container
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (cat['color'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat['icon'] as IconData,
                            color: cat['color'] as Color,
                            size:
                                itemWidth *
                                0.35, // Width ke hisab se icon scale hoga
                          ),
                        ),
                        SizedBox(height: context.rH(1)),
                        // Auto-scaling text jaisa feel dene ke liye FittedBox
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              cat['label'] as String,
                              style: TextStyle(
                                fontSize:
                                    itemWidth * 0.14, // Responsive font size
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
