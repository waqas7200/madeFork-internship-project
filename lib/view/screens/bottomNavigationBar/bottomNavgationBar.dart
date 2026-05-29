// import 'dart:async';
// import 'package:flutter/material.dart';
//
// //────────────────────────────────────────────
// //  MAIN SCREEN (Bottom Nav wrapper)
// // ─────────────────────────────────────────────
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _pages = const [
//     HomeScreen(),
//     Center(child: Text('Orders', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Chat', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: AppBottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  HOME SCREEN
// // ─────────────────────────────────────────────
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ── TOP HEADER (teal bg) ──
//               const AppHeader(),
//               // ── SEARCH BAR ──
//               const SearchBarWidget(),
//               const SizedBox(height: 12),
//               // ── CATEGORY MENU BUTTONS ──
//               const CategoryMenu(),
//               const SizedBox(height: 14),
//               // ── AUTO-SWIPE BANNER ADS ──
//               const BannerSlider(),
//               const SizedBox(height: 16),
//               // ── RECOMMENDATION SECTION ──
//               const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
//               const SizedBox(height: 10),
//               const RecommendationList(),
//               const SizedBox(height: 16),
//               // ── NEARBY SECTION ──
//               const SectionHeader(title: 'Nearby', actionLabel: 'View All'),
//               const SizedBox(height: 10),
//               const NearbyList(),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  HEADER
// // ─────────────────────────────────────────────
// class AppHeader extends StatelessWidget {
//   const AppHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF00897B),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Left: greeting + title
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Explore the taste',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.85),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const Text(
//                 'of Asian Food',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),
//           // Right: cart icon + profile avatar
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
//                 onPressed: () {},
//               ),
//               const SizedBox(width: 4),
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundImage: NetworkImage(
//                   'https://i.pravatar.cc/150?img=47',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  SEARCH BAR
// // ─────────────────────────────────────────────
// class SearchBarWidget extends StatelessWidget {
//   const SearchBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF00897B),
//       padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search food, restaurants...',
//           hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.tune, color: Color(0xFF00897B)),
//             onPressed: () {},
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(vertical: 0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  CATEGORY MENU
// // ─────────────────────────────────────────────
// class CategoryMenu extends StatelessWidget {
//   const CategoryMenu({super.key});
//
//   static const List<Map<String, dynamic>> _categories = [
//     {'icon': Icons.apple, 'label': 'Fruit', 'color': Color(0xFFE57373)},
//     {'icon': Icons.lunch_dining, 'label': 'Burger', 'color': Color(0xFFFF8A65)},
//     {'icon': Icons.icecream, 'label': 'Yogurt', 'color': Color(0xFFFFCA28)},
//     {'icon': Icons.cake, 'label': 'Cream', 'color': Color(0xFF64B5F6)},
//     {'icon': Icons.local_pizza, 'label': 'Pizza', 'color': Color(0xFF81C784)},
//     {'icon': Icons.coffee, 'label': 'Drinks', 'color': Color(0xFFA1887F)},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: _categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, i) {
//           final cat = _categories[i];
//           return CategoryItem(
//             icon: cat['icon'] as IconData,
//             label: cat['label'] as String,
//             color: cat['color'] as Color,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CategoryItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//
//   const CategoryItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: color.withOpacity(0.3)),
//           ),
//           child: Icon(icon, color: color, size: 28),
//         ),
//         const SizedBox(height: 6),
//         Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  AUTO-SWIPE BANNER SLIDER
// // ─────────────────────────────────────────────
// class BannerSlider extends StatefulWidget {
//   const BannerSlider({super.key});
//
//   @override
//   State<BannerSlider> createState() => _BannerSliderState();
// }
//
// class _BannerSliderState extends State<BannerSlider> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;
//   Timer? _timer;
//
//   static const List<Map<String, String>> _banners = [
//     {
//       'title': 'Eat gelato like\nthere\'s no tomorrow!',
//       'sub': 'Hello! Luke Thomp',
//       'discount': '50%\nAll Items',
//       'image': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400',
//       'bg': '0xFF00897B',
//     },
//     {
//       'title': 'Fresh burgers\ndelivered fast!',
//       'sub': 'Hello! Sarah K.',
//       'discount': '30%\nBurgers',
//       'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
//       'bg': '0xFFE65100',
//     },
//     {
//       'title': 'Sweet drinks\nfor sweet moments',
//       'sub': 'Hello! John D.',
//       'discount': '20%\nDrinks',
//       'image': 'https://images.unsplash.com/photo-1437418747212-8d9709afab22?w=400',
//       'bg': '0xFF1565C0',
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 3), (_) {
//       final next = (_currentPage + 1) % _banners.length;
//       _controller.animateToPage(
//         next,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 150,
//           child: PageView.builder(
//             controller: _controller,
//             itemCount: _banners.length,
//             onPageChanged: (i) => setState(() => _currentPage = i),
//             itemBuilder: (context, i) {
//               final b = _banners[i];
//               final bgColor = Color(int.parse(b['bg']!));
//               return BannerCard(
//                 title: b['title']!,
//                 sub: b['sub']!,
//                 discount: b['discount']!,
//                 imageUrl: b['image']!,
//                 bgColor: bgColor,
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 8),
//         // Dots indicator
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(_banners.length, (i) {
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 3),
//               width: _currentPage == i ? 20 : 7,
//               height: 7,
//               decoration: BoxDecoration(
//                 color: _currentPage == i
//                     ? const Color(0xFF00897B)
//                     : Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
//
// class BannerCard extends StatelessWidget {
//   final String title, sub, discount, imageUrl;
//   final Color bgColor;
//
//   const BannerCard({
//     super.key,
//     required this.title,
//     required this.sub,
//     required this.discount,
//     required this.imageUrl,
//     required this.bgColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(sub,
//                       style: TextStyle(
//                           color: Colors.white.withOpacity(0.8), fontSize: 11)),
//                   const SizedBox(height: 4),
//                   Text(title,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           height: 1.3)),
//                 ],
//               ),
//             ),
//           ),
//           // Discount badge
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.red.shade600,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(discount,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w800)),
//           ),
//           // Food image
//           Expanded(
//             flex: 2,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(16),
//                 bottomRight: Radius.circular(16),
//               ),
//               child: Image.network(
//                 imageUrl,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(color: Colors.white24),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  SECTION HEADER
// // ─────────────────────────────────────────────
// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String actionLabel;
//
//   const SectionHeader({
//     super.key,
//     required this.title,
//     required this.actionLabel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
//           TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             child: Text(actionLabel,
//                 style: const TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFF00897B),
//                     fontWeight: FontWeight.w600)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  RECOMMENDATION LIST
// // ─────────────────────────────────────────────
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
//     return SizedBox(
//       height: 200,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: _items.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, i) => RecommendationCard(item: _items[i]),
//       ),
//     );
//   }
// }
//
// class RecommendationCard extends StatelessWidget {
//   final Map<String, String> item;
//
//   const RecommendationCard({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 140,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.07),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//             child: Image.network(
//               item['image']!,
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) =>
//                   Container(height: 100, color: Colors.grey.shade200),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(item['name']!,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: 13)),
//                 Text(item['store']!,
//                     style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
//                 const SizedBox(height: 4),
//                 Text(item['price']!,
//                     style: const TextStyle(
//                         color: Color(0xFFE53935),
//                         fontWeight: FontWeight.w700,
//                         fontSize: 13)),
//               ],
//             ),
//           ),
//           // Add to cart button
//           Padding(
//             padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//             child: SizedBox(
//               width: double.infinity,
//               height: 28,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.add, size: 14),
//                 label: const Text('Add to cart', style: TextStyle(fontSize: 11)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00897B),
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  NEARBY LIST
// // ─────────────────────────────────────────────
// class NearbyList extends StatelessWidget {
//   const NearbyList({super.key});
//
//   static const List<Map<String, String>> _items = [
//     {
//       'name': 'Starbucks',
//       'address': 'Alaminos, Pang',
//       'distance': '18 km',
//       'rating': '4.5',
//       'image': 'https://images.unsplash.com/photo-1601314212543-b0e2eabe3a0e?w=200',
//     },
//     {
//       'name': 'OwlEnergy',
//       'address': 'Dagupan, Pang',
//       'distance': '12 km',
//       'rating': '4.2',
//       'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200',
//     },
//     {
//       'name': 'NiceeCire',
//       'address': 'Dagupan, Pang',
//       'distance': '12 km',
//       'rating': '4.7',
//       'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=200',
//     },
//     {
//       'name': 'BurgerZone',
//       'address': 'Lingayen, Pang',
//       'distance': '8 km',
//       'rating': '4.3',
//       'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: _items.length,
//       separatorBuilder: (_, __) => const SizedBox(height: 10),
//       itemBuilder: (context, i) => NearbyCard(item: _items[i]),
//     );
//   }
// }
//
// class NearbyCard extends StatelessWidget {
//   final Map<String, String> item;
//
//   const NearbyCard({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Row(
//         children: [
//           // Circle avatar with image
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: NetworkImage(item['image']!),
//             onBackgroundImageError: (_, __) {},
//           ),
//           const SizedBox(width: 12),
//           // Info column
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(item['name']!,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 14)),
//                     const SizedBox(width: 4),
//                     const Icon(Icons.verified, color: Color(0xFF00897B), size: 14),
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//                 Text(item['address']!,
//                     style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.amber, size: 13),
//                     const SizedBox(width: 2),
//                     Text(item['rating']!,
//                         style: const TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w600)),
//                     const SizedBox(width: 8),
//                     const Icon(Icons.location_on_outlined,
//                         size: 13, color: Colors.grey),
//                     const SizedBox(width: 2),
//                     Text(item['distance']!,
//                         style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Distance badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00897B).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               item['distance']!,
//               style: const TextStyle(
//                   color: Color(0xFF00897B),
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  BOTTOM NAVIGATION BAR (Custom Widget)
// // ─────────────────────────────────────────────
// class AppBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//
//   const AppBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   static const List<Map<String, dynamic>> _navItems = [
//     {'icon': Icons.home_rounded, 'label': 'Home'},
//     {'icon': Icons.receipt_long_outlined, 'label': 'Orders'},
//     {'icon': Icons.chat_bubble_outline, 'label': 'Chat'},
//     {'icon': Icons.person_outline, 'label': 'Profile'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 16,
//               offset: const Offset(0, -4))
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(_navItems.length, (i) {
//               final item = _navItems[i];
//               final isSelected = currentIndex == i;
//               return GestureDetector(
//                 onTap: () => onTap(i),
//                 behavior: HitTestBehavior.opaque,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? const Color(0xFF00897B).withOpacity(0.1)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         item['icon'] as IconData,
//                         color: isSelected
//                             ? const Color(0xFF00897B)
//                             : Colors.grey.shade400,
//                         size: 24,
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         item['label'] as String,
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: isSelected
//                               ? const Color(0xFF00897B)
//                               : Colors.grey.shade400,
//                           fontWeight: isSelected
//                               ? FontWeight.w700
//                               : FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';

import '../../component/customRecomandation/customRcomandaion.dart';
import '../../component/custombottomnavigationbar/customnavigationbar.dart';
import '../alloferscreen/allofferscren.dart';
import '../homeScreen/HomeScreen.dart';
import '../homeScreen/comandationscreen/productdetailscreen/favoritescreen/favoritescreen.dart';
import '../paymentscreen/paymentscreen.dart';
import '../rderhistory/orderhistory.dart';
import '../userprofilescreen+edit/userprofilescreen+edit.dart';




import '../../utils/responsiveClass/responosiveC;ass.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    OrderHistoryScreen(),
    PaymentMethodScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}




