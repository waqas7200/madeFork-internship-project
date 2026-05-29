
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
    APPResponsive().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: context.rH(10),
       //title:
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
                  height: context.rH(5),
                  width: context.rW(4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rW(4) ),
                  child: Row(
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
                ),
                SizedBox(
                  height: context.rH(3),
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
                 NearbyList(),
                SizedBox(height: context.rH(2.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}