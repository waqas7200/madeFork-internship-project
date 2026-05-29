
// ─────────────────────────────────────────────
//  NEARBY LIST
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';

import '../../../component/customNearby/customNearby.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/customNearby/customNearby.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../../../controller/nearby_controller.dart';

class NearbyList extends StatelessWidget {
  NearbyList({super.key});

  final NearbyController controller = Get.put(NearbyController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      }

      if (controller.nearbyRestaurants.isEmpty) {
        return const Center(child: Text('No nearby restaurants found.'));
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
        itemCount: controller.nearbyRestaurants.length > 5 ? 5 : controller.nearbyRestaurants.length,
        separatorBuilder: (_, __) => SizedBox(height: context.rH(1.2)),
        itemBuilder: (context, i) {
          final rest = controller.nearbyRestaurants[i];
          // NearbyCard expects Map<String, String> based on previous code
          final mapItem = {
            'name': rest.name,
            'address': rest.address,
            'distance': rest.distanceStr,
            'rating': rest.rating,
            'image': rest.image,
          };
          return NearbyCard(item: mapItem, restaurant: rest);
        },
      );
    });
  }
}
