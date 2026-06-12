import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/costsColors/constColors.dart';
import '../utils/responsiveClass/responosiveC;ass.dart';
import '../../controller/auth_Cntroller/auth_Controller.dart';

class CustomHomeAppBar extends StatelessWidget {
  final int totalCartItems;
  final VoidCallback? onCartTap;
  final String titleLine1;
  final String? titleLine2;
  final bool showBackButton;
  final Widget? trailing;

  const CustomHomeAppBar({
    super.key,
    this.totalCartItems = 0,
    this.onCartTap,
    this.titleLine1 = 'Explore the taste',
    this.titleLine2 = 'of Asian Food',
    this.showBackButton = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.isRegistered<AuthController>() 
        ? Get.find<AuthController>() 
        : Get.put(AuthController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (showBackButton) ...[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: context.rW(3)),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleLine1,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.85),
                      fontSize: APPResponsive.fs(3.2, min: 11, max: 15),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (titleLine2 != null)
                    Text(
                      titleLine2!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: APPResponsive.fs(4.5, min: 15, max: 22),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (trailing != null)
            trailing!
          else if (onCartTap != null)
            Row(
              children: [
                GestureDetector(
                  onTap: onCartTap,
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
                      if (totalCartItems > 0)
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
                              '$totalCartItems',
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
                Obx(() {
                  final profileImage = authCtrl.currentUser.value?.profileImage;
                  return CircleAvatar(
                    radius: context.rW(5).clamp(18, 26),
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: profileImage != null && profileImage.isNotEmpty
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
