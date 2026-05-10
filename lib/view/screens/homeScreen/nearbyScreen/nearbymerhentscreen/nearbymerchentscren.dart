import 'package:flutter/material.dart';
import '../../../../component/customCircleAvator/customCircleavators.dart';
import '../../../../utils/costsColors/constColors.dart';
import '../../../bottomNavigationBar/bottomNavgationBar.dart';

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
                        hintStyle: TextStyle(fontSize: context.fs(3.5), color: Colors.grey),
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
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(2)),
                    itemCount: 4, // Example count
                    itemBuilder: (context, index) {
                      return const MerchantCard();
                    },
                  ),
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
              fontSize: context.fs(4.5),
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
                      fontSize: context.fs(3.5),
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
  const MerchantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.rH(2.5)),
      padding: EdgeInsets.all(context.rW(3)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // First Row: Logo, Name, Distance
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: context.rW(15),
              //   height: context.rW(15),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     image: const DecorationImage(
              //       image:
              //       NetworkImage('https://images.unsplash.com/photo-1601314212543-b0e2eabe3a0e?w=200'),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
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
                  child: Image(image: AssetImage('assets/splash_Icon/img.png')),
                ),
              ),

              SizedBox(width: context.rW(3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'StarBuckz',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.fs(4)),
                    ),
                    Text('Alaminos, Pang', style: TextStyle(color: Colors.grey, fontSize: context.fs(3))),
                    Text('Jul 05, 2022', style: TextStyle(color: Colors.grey, fontSize: context.fs(3))),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('18.00 km', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: context.fs(3))),
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: const Icon(Icons.card_giftcard, size: 14, color: Colors.orange),
                  ),
                  Text('Rewards', style: TextStyle(fontSize: context.fs(2.5), color: Colors.orange)),
                ],
              )
            ],
          ),
          SizedBox(height: context.rH(1.5)),
          // Second Row: Food Images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _foodThumb(context, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=400](https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=400'),
              _foodThumb(context, 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'),
              _seeMoreThumb(context),
            ],
          )
        ],
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
          Text('See more', style: TextStyle(fontSize: context.fs(2.5), color: Colors.grey)),
        ],
      ),
    );
  }
}