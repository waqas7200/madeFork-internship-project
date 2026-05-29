import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../component/customCircleAvator/customCircleavators.dart';
import '../../../../utils/costsColors/constColors.dart';
import '../../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../../bottomNavigationBar/bottomNavgationBar.dart';
import '../../../../../controller/nearby_controller.dart';
import '../../../../../model/nerabyresturentModel/nearbyresturntModl.dart';
import '../restaurantDetailScreen/restaurant_detail_screen.dart';

class NearByMerchantScreen extends StatefulWidget {
  const NearByMerchantScreen({super.key});

  @override
  State<NearByMerchantScreen> createState() => _NearByMerchantScreenState();
}

class _NearByMerchantScreenState extends State<NearByMerchantScreen> {
  int selectedTabIndex = 0;
  final List<String> categories = ["All Location", "Breakfast", "Lunch", "Dinner"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Background Circles (Same as Home) ---


          Positioned(
            // Height aur Width ka hisab laga kar negative offset set kiya hai
            top:-345,
            //-context.rH(45),
            left: -context.rW(4),
            child: Transform.rotate(
              angle: -0,
              child: Container(
                // Screen ki width ke mutabiq size adjust hoga
                width: context.rW(110),
                height: context.rW(120),
                decoration: BoxDecoration(
                  color: AppColor.backgroundYellow,
                  // Curve ko bhi responsive rakha hai
                  borderRadius: BorderRadius.circular(context.rW(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // --- Custom AppBar ---
                _buildAppBar(context),

                // --- Search Bar ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(1)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Find for food or restaurant",
                        hintStyle: TextStyle(fontSize: APPResponsive.fs(3.5), color: Colors.grey),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: context.rH(1.5)),
                      ),
                    ),
                  ),
                ),

                // --- LinkedIn Style Tabs ---
                _buildTabs(),

                // --- Merchant List ---
                Expanded(
                  child: Obx(() {
                    final controller = Get.isRegistered<NearbyController>()
                        ? Get.find<NearbyController>()
                        : Get.put(NearbyController());

                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.errorMessage.value.isNotEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    if (controller.nearbyRestaurants.isEmpty) {
                      return const Center(
                        child: Text(
                          "No nearby merchants found.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(2)),
                      itemCount: controller.nearbyRestaurants.length,
                      itemBuilder: (context, index) {
                        return MerchantCard(
                          restaurant: controller.nearbyRestaurants[index],
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rW(4), vertical: context.rH(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          Text(
            'Near by Merchant',
            style: TextStyle(
              fontSize: APPResponsive.fs(4.5),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: AppColor.backgroundBlue),
              SizedBox(width: context.rW(3)),
              CircleAvatar(
                radius: context.rW(4),
                backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=47'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: context.rH(5),
      margin: EdgeInsets.only(top: context.rH(1)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.rW(5)),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTabIndex = index),
            child: Container(
              margin: EdgeInsets.only(right: context.rW(6)),
              child: Column(
                children: [
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.orange : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: APPResponsive.fs(3.5),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      // Top margin ko screen height ke hisab se adjust kiya
                      margin: EdgeInsets.only(top: context.rH(0.5)),

                      // Height ko screen height ke hisab se (min/max constraints ke sath)
                      height: context.rH(0.3).clamp(2.0, 4.0),

                      // Width ko screen width ka 12% rakha hai taake text ke sath proportionate rahe
                      width: context.rW(12),

                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Premium look ke liye thora sa curve (Optional)
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- Merchant Card Widget ---
class MerchantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const MerchantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
          ),
        );
      },
      child: Container(
      margin: EdgeInsets.only(bottom: context.rH(2.5)),
      padding: EdgeInsets.all(context.rW(3)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: Logo, Name, Distance
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.rW(16), // Thora size barha diya design ke liye
                height: context.rW(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Image load hone se pehle ye dikhega
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade100), // Premium border
                ),
                // ClipRRect use karein taake image corners ke bahar na nikalay
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    restaurant.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('assets/splash_Icon/img.png'), fit: BoxFit.cover);
                    },
                  ),
                ),
              ),

              SizedBox(width: context.rW(3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: APPResponsive.fs(4)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Owner: ${restaurant.ownerName}',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: APPResponsive.fs(3)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      restaurant.address,
                      style: TextStyle(color: Colors.grey, fontSize: APPResponsive.fs(3)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    restaurant.distanceStr,
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: APPResponsive.fs(3)),
                  ),
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: const Icon(Icons.card_giftcard, size: 14, color: Colors.orange),
                  ),
                  Text('Rewards', style: TextStyle(fontSize: APPResponsive.fs(2.5), color: Colors.orange)),
                ],
              )
            ],
          ),
          if (restaurant.description.isNotEmpty) ...[
            SizedBox(height: context.rH(1.5)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.rW(2)),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                restaurant.description,
                style: TextStyle(
                  fontSize: APPResponsive.fs(2.8),
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          SizedBox(height: context.rH(1.5)),
          // Second Row: Food Images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _foodThumb(context, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=400'),
              _foodThumb(context, 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'),
              _seeMoreThumb(context),
            ],
          )
        ],
      ),
      ),
    );
  }

  Widget _foodThumb(BuildContext context, String url) {
    return Container(
      width: context.rW(26),
      height: context.rH(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _seeMoreThumb(BuildContext context) {
    return Container(
      width: context.rW(26),
      height: context.rH(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
          Text('See more', style: TextStyle(fontSize: APPResponsive.fs(2.5), color: Colors.grey)),
        ],
      ),
    );
  }
}