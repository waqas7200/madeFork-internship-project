import 'package:flutter/material.dart';
import '../../../component/customCircleAvator/customCircleavators.dart';
import '../../../component/secinHeader/sectionHeader.dart';
import '../../../utils/costsColors/constColors.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';
import '../comandationscreen/recomandatioScren.dart';
import '../nearbyScreen/nearbyList.dart';
import 'catageryiteam/catageryiteam.dart';

class CatagerytScreen extends StatefulWidget {
  const CatagerytScreen({super.key});

  @override
  State<CatagerytScreen> createState() => _CatagerytScreenState();
}

class _CatagerytScreenState extends State<CatagerytScreen> {



  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Stack(
    //     children: [
    //       // --- Background Circles (Same as Home) ---
    //
    //
    //       Positioned(
    //         top: -280,
    //         right: -15,
    //         child: BackgroundCircle(size: 500, color: AppColor.backgroundYellow),
    //       ),
    //       Positioned(
    //         top: -300,
    //         left: -100,
    //         child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
    //       ),
    //       Positioned(
    //         top: -200,
    //         left: -50,
    //         child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
    //       ),
    //
    //       Expanded(
    //         child: SafeArea(
    //           child: Column(
    //             children: [
    //               // --- Custom AppBar ---
    //               _buildAppBar(context),
    //
    //               const CategoryMenu(),
    //               SizedBox(height: context.rH(1.8)),
    //
    //               // --- Search Bar ---
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(1)),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(30),
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.black.withOpacity(0.05),
    //                         blurRadius: 10,
    //                         offset: const Offset(0, 5),
    //                       )
    //                     ],
    //                   ),
    //                   child: TextField(
    //                     decoration: InputDecoration(
    //                       hintText: "Find for food or restaurant",
    //                       hintStyle: TextStyle(fontSize: context.fs(3.5), color: Colors.grey),
    //                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
    //                       border: InputBorder.none,
    //                       contentPadding: EdgeInsets.symmetric(vertical: context.rH(1.5)),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //
    //               SizedBox(height: context.rH(1.8)),
    //               const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
    //               SizedBox(height: context.rH(1.2)),
    //               const RecommendationList(),
    //               // --- Merchant List ---
    //               Expanded(
    //                 child: ListView.builder(
    //                   physics: const NeverScrollableScrollPhysics(), // List
    //                   padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(2)),
    //                   itemCount: 4, // Example count
    //                   itemBuilder: (context, index) {
    //                     return const catageryard();
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Background Circles (As it is) ---

      Positioned(
              top: -350,
              right: -10,
              child: BackgroundCircle(size: 500, color: AppColor.backgroundYellow),
            ),
            Positioned(
              top: -370,
              left: -100,
              child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
            ),
            Positioned(
              top: -270,
              left: -50,
              child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
            ),
          // --- Main Content (Fix yahan hai) ---
          Positioned.fill( // Expanded hata kar ye lagayein taake poori space milay
            child: SafeArea(
              child: SingleChildScrollView( // Poori screen ko scrollable banayein
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // 1. AppBar
                    _buildAppBar(context),

                    // 2. Menu
                    const CategoryMenu(),
                    SizedBox(height: context.rH(1.8)),

                    SizedBox(height: context.rH(1.8)),
                    const SectionHeader(title: 'Recommendation', actionLabel: 'See All'),
                    SizedBox(height: context.rH(1.2)),

                    const RecommendationList(),

                    SizedBox(height: context.rH(1.8)),
                    const SectionHeader(title: 'Popular', actionLabel: 'See All'),
                    // 4. Merchant List (ListView)
                    ListView.builder(
                      shrinkWrap: true, // ZAROORI: Kyunki hum Column ke andar hain
                      physics: const NeverScrollableScrollPhysics(), // Scroll parent handle karega
                      padding: EdgeInsets.symmetric(horizontal: context.rW(5), vertical: context.rH(2)),
                      itemCount: 10, // Check karne ke liye count barha dein
                      itemBuilder: (context, index) {
                        return const catageryard();
                      },
                    ),
                  ],
                ),
              ),
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


}

// --- Merchant Card Widget ---
class catageryard extends StatelessWidget {
  const catageryard({super.key});

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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: APPResponsive.fs(4)),
                    ),
                    Text('Alaminos, Pang', style: TextStyle(color: Colors.grey, fontSize: APPResponsive.fs(3))),
                    Text('18.00 km', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: APPResponsive.fs(3))),

                  ],
                ),
              ),
              Column(
                children: [

                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: const Icon(Icons.bookmark, size: 18, color: Colors.orange),
                  ),
                  SizedBox(height: context.rW(3)),
                  Text('price :200', style: TextStyle(fontSize: APPResponsive.fs(2.5), color: Colors.orange)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }



}