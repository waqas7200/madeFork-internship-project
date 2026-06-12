import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/recommendation_controller.dart';
import '../../../component/custom_background/custom_background.dart';
import '../../../component/custom_home_appbar.dart';
import '../../../component/customRecomandation/customRcomandaion.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../../component/custom_loading_widget.dart';

class AllRecommendationsScreen extends StatelessWidget {
  const AllRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecommendationController ctrl = Get.find<RecommendationController>();

    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomHomeAppBar(
                showBackButton: true,
                titleLine1: 'All',
                titleLine2: 'Recommendations',
              ),
              Expanded(
                child: Obx(() {
                  if (ctrl.isLoading.value &&
                      ctrl.recommendedProducts.isEmpty) {
                    return const Center(child: CustomLoadingWidget());
                  }

                  if (ctrl.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        ctrl.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final products = ctrl.recommendedProducts;

                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        'No recommendations available yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.rW(4),
                      vertical: context.rH(2),
                    ),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.rW(3),
                      mainAxisSpacing: context.rH(2),
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final cardW =
                          (MediaQuery.of(context).size.width / 2) -
                          context.rW(6);
                      return RecommendationCard(
                        item: products[index],
                        cardWidth: cardW,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
