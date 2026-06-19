// ─────────────────────────────────────────────
//  HOME SCREEN
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madeforke_app/view/screens/homeScreen/searchbar/sarhbar.dart';

import '../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../component/customCircleAvator/customCircleavators.dart';
import '../../component/custom_background/custom_background.dart';
import '../../component/custom_home_appbar.dart';
import '../../component/secinHeader/sectionHeader.dart';
import 'package:madeforke_app/utils/app_routes.dart';
import '../../utils/costsColors/constColors.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';

import 'appheaders/appheaders.dart';
import 'autoBanner/autoBanner.dart';

import 'catageryscreen/catageryiteam/catageryiteam.dart';
import 'comandationscreen/recomandatioScren.dart';
import 'comandationscreen/all_recommendations_screen.dart';
import 'myorderScreenCart/myOrderCart.dart';
import 'nearbyScreen/nearbyList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<HomeScreen> {
  //List<Product> favoriteItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.rH(5), width: context.rW(4)),
              CustomHomeAppBar(
                onCartTap: () async {
                  await Get.toNamed(AppRoutes.myOrder);
                },
              ),
              SizedBox(height: context.rH(3), width: context.rW(4)),
              const SearchBarWidget(),
              SizedBox(height: context.rH(1.5)),
              const BannerSlider(),
              SizedBox(height: context.rH(2)),
              const CategoryMenu(),
              SizedBox(height: context.rH(1.8)),
              SectionHeader(
                title: 'Recommendation',
                actionLabel: 'See All',
                onActionTap: () =>
                    Get.to(() => const AllRecommendationsScreen()),
              ),
              SizedBox(height: context.rH(1.2)),
              const RecommendationList(),
              SizedBox(height: context.rH(2)),
              SectionHeader(
                title: 'Nearby',
                actionLabel: 'View All',
                onActionTap: () => Get.toNamed(AppRoutes.nearbyAll),
              ),
              SizedBox(height: context.rH(1.2)),
              NearbyList(),
              SizedBox(height: context.rH(2.5)),
            ],
          ),
        ),
      ),
    );
  }
}
