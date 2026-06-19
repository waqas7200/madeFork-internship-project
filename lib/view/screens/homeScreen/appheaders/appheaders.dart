// ─────────────────────────────────────────────
//  HEADER
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';
import 'package:get/get.dart';
import '../../../../controller/auth_Cntroller/auth_Controller.dart';
import '../myorderScreenCart/myOrderCart.dart';
import 'package:madeforke_app/utils/app_routes.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: context.rW(4),
        vertical: context.rH(1.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the taste',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: APPResponsive.fs(3.2, min: 11, max: 15),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'of Asian Food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: APPResponsive.fs(4.5, min: 15, max: 22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.myOrder);
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: context.rW(6).clamp(20, 30),
                    ),
                    Obx(() {
                      int total = 0;
                      for (var item in cartItems) {
                        total += item.quantity;
                      }
                      if (total == 0) return const SizedBox.shrink();
                      return Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$total',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(width: context.rW(3)),
              Obx(() {
                final authCtrl = Get.isRegistered<AuthController>()
                    ? Get.find<AuthController>()
                    : Get.put(AuthController());
                final profileImage = authCtrl.currentUser.value?.profileImage;
                return CircleAvatar(
                  radius: context.rW(5).clamp(18, 26),
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      profileImage != null && profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : null,
                  child: profileImage == null || profileImage.isEmpty
                      ? Icon(Icons.person, color: Colors.grey.shade400)
                      : null,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
