// // ─────────────────────────────────────────────
// //  HOME SCREEN
// // ─────────────────────────────────────────────
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:madeforke_app/view/screens/homeScreen/searchbar/sarhbar.dart';
//
// import '../../component/customCircleAvator/customCircleavators.dart';
// import '../../component/secinHeader/sectionHeader.dart';
// import '../../utils/costsColors/constColors.dart';
// import '../../utils/responsiveClass/responosiveC;ass.dart';
// import '../bottomNavigationBar/bottomNavgationBar.dart';
// import 'appheaders/appheaders.dart';
// import 'autoBanner/autoBanner.dart';
// import 'catageryItem/catageryiteam.dart';
// import 'comandationscreen/recomandatioScren.dart';
// import 'nearbyScreen/nearbyList.dart';
// import 'nearbyScreen/nearbymerhentscreen/nearbymerchentscren.dart';
//
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor:Colors.white,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const AppHeader(),
// //               const SearchBarWidget(),
// //               SizedBox(height: context.rH(1.5)),
// //               const CategoryMenu(),
// //               SizedBox(height: context.rH(1.8)),
// //               const BannerSlider(),
// //               SizedBox(height: context.rH(2)),
// //               const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
// //               SizedBox(height: context.rH(1.2)),
// //               const RecommendationList(),
// //               SizedBox(height: context.rH(2)),
// //               const SectionHeader(title: 'Nearby', actionLabel: 'View All'),
// //               SizedBox(height: context.rH(1.2)),
// //               const NearbyList(),
// //               SizedBox(height: context.rH(2.5)),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
// //
// // import '../../component/customCircleAvator/customCircleavators.dart';
// // import '../../utils/responsiveClass/responosiveC;ass.dart';
// //
// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});
// //
// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }
// //
// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   final PageController _pageController = PageController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     AppResponsive().init(context); // Responsive init
// //
// //     return Scaffold(
// //       backgroundColor:AppColor.backgroundBlue , // Green Background
// //       body: Stack(
// //         children: [
// //           // --- Upper Right Background Design ---
// //           Positioned(
// //             top:-280,
// //             right: -15,
// //             child: BackgroundCircle(size: 500, color:AppColor.backgroundYellow),
// //           ),
// //           Positioned(
// //             top: -300,
// //             left: -100,
// //             child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
// //           ),
// //           // Thick White Line Circle (Upper Right)
// //           Positioned(
// //             top:-200,
// //             left: -50,
// //             child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
// //           ),
// //
// //           // --- Lower Left Background Design ---
// //           Positioned(
// //             bottom: -230,
// //             left: -40,
// //             child: BackgroundCircle(size: 450, color: Colors.yellow.shade700),
// //           ),
// //           // Thick White Line Circle (Lower Left)
// //           Positioned(
// //             bottom: -250,
// //             right: -180,
// //             child: const BackgroundCircle(size: 580, color: Colors.transparent, hasBorder: true),
// //           ),
// //
// //           // --- UI Content ---
// //           PageView.builder(
// //             controller: _pageController,
// //             itemCount: 3,
// //             itemBuilder: (context, index) {
// //               return OnboardingContent(
// //                 title: "MadeFork Screen ${index + 1}",
// //                 description: "Clean, responsive UI with custom designs.",
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class OnboardingContent extends StatelessWidget {
// //   final String title, description;
// //   const OnboardingContent({super.key, required this.title, required this.description});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const Spacer(flex: 3),
// //           // Aapka image ya illustration yahan aayega
// //           const FlutterLogo(size: 150),
// //           const Spacer(),
// //           Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: AppResponsive.width(8), // Responsive text
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           const SizedBox(height: 15),
// //           Text(
// //             description,
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: AppResponsive.width(4.5),
// //               color: Colors.white70,
// //             ),
// //           ),
// //           const Spacer(flex: 2),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<HomeScreen> {
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       extendBodyBehindAppBar: true, // 👈 body AppBar ke peeche se shuru hogi
//
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0, // 👈 scroll par bhi background na aaye
//         toolbarHeight: context.rH(10),
//         title:  Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Explore the taste',
//                   style: TextStyle(
//                     color: Colors.black.withOpacity(0.85),
//                     fontSize: context.fs(3.2, min: 11, max: 15),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 Text(
//                   'of Asian Food',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: context.fs(4.5, min: 15, max: 22),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: context.rW(6).clamp(18, 26),
//                    backgroundColor: AppColor.backgroundBlue,
//                   child:   Icon(
//                     Icons.shopping_cart_outlined,
//                     color: AppColor.backgroundYellow,
//                     size: context.rW(6).clamp(20, 30),
//                   ),
//                 ),
//
//                 SizedBox(width: context.rW(3)),
//                 CircleAvatar(
//                   radius: context.rW(5).clamp(18, 26),
//                   backgroundImage: const NetworkImage(
//                     'https://i.pravatar.cc/150?img=47',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//
//         ],
//       ),
//       backgroundColor:Colors.white,
//       body: Stack(
//         children: [
//
//
//           // --- Upper Right Background Design ---
//           Positioned(
//             top: -280,
//             right: -15,
//             child: BackgroundCircle(size: 500, color: AppColor.backgroundYellow),
//           ),
//           Positioned(
//             top: -300,
//             left: -100,
//             child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
//           ),
//           Positioned(
//             top: -200,
//             left: -50,
//             child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
//           ),
//
//
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // const AppHeader(),
//                 SizedBox(
//                   height:  context.rH(10),
//                   width:  context.rW(4),
//                 ),
//
//                 const SearchBarWidget(),
//                 SizedBox(height: context.rH(1.5)),
//                 const BannerSlider(),
//                 SizedBox(height: context.rH(2)),
//                 const CategoryMenu(),
//                 SizedBox(height: context.rH(1.8)),
//                 const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
//                 SizedBox(height: context.rH(1.2)),
//                 const RecommendationList(),
//                 SizedBox(height: context.rH(2)),
//                 // Nearby section header in HomeScreen
//                 SectionHeader(
//                   title: 'Nearby',
//                   actionLabel: 'View All',
//                   onActionTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const NearByMerchantScreen()),
//                     );
//                   },
//                 ),
//                // const SectionHeader(title: 'Nearby', actionLabel: 'View All'),
//                 SizedBox(height: context.rH(1.2)),
//                 const NearbyList(),
//                 SizedBox(height: context.rH(2.5)),
//               ],
//             ),
//           ),
// ]
//       ),
//     );
//   }
// }

// ─────────────────────────────────────────────
//  HOME SCREEN
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madeforke_app/view/screens/homeScreen/searchbar/sarhbar.dart';

import '../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../component/customCircleAvator/customCircleavators.dart';
import '../../component/secinHeader/sectionHeader.dart';
import '../../utils/costsColors/constColors.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';

import 'appheaders/appheaders.dart';
import 'autoBanner/autoBanner.dart';

import 'catageryscreen/catageryiteam/catageryiteam.dart';
import 'comandationscreen/recomandatioScren.dart';
import 'myorderScreenCart/myOrderCart.dart';
import 'nearbyScreen/nearbyList.dart';
import 'nearbyScreen/nearbymerhentscreen/nearbymerchentscren.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<HomeScreen> {
  //List<Product> favoriteItems = [];
  int _totalCartItems = 0;

  @override
  void initState() {
    super.initState();
    _updateCartCount();
  }

  void _updateCartCount() {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity;
    }
    setState(() {
      _totalCartItems = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontSize: context.fs(3.2, min: 11, max: 15),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'of Asian Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: context.fs(4.5, min: 15, max: 22),
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -280,
            right: -15,
            child: BackgroundCircle(size: 500, color: AppColor.backgroundYellow),
          ),
          Positioned(
            top: -300,
            left: -100,
            child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
          ),
          Positioned(
            top: -200,
            left: -50,
            child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.rH(10),
                  width: context.rW(4),
                ),
                const SearchBarWidget(),
                SizedBox(height: context.rH(1.5)),
                const BannerSlider(),
                SizedBox(height: context.rH(2)),
                const CategoryMenu(),
                SizedBox(height: context.rH(1.8)),
                const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
                SizedBox(height: context.rH(1.2)),
                const RecommendationList(),
                SizedBox(height: context.rH(2)),
                SectionHeader(
                  title: 'Nearby',
                  actionLabel: 'View All',
                  onActionTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NearByMerchantScreen()),
                    );
                  },
                ),
                SizedBox(height: context.rH(1.2)),
                const NearbyList(),
                SizedBox(height: context.rH(2.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}