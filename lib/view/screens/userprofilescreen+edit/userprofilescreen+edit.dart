import 'package:flutter/material.dart';
import 'package:madeforke_app/view/screens/userprofilescreen+edit/reusablemenutiel/resuablemenutile.dart';

import '../../../model/userprofilemodel/userprofilemodel.dart';
import '../../component/custom_signout_dilog/custom_sign_out_dilog.dart';
import 'aboutUsScreen/aboutUsScreen.dart';
import 'editprofilescreen/editprofilescreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ProfileData.user;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      body: Stack(
        children: [
          // 🔶 Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Profile", style: TextStyle(color: Colors.white)),
                        Icon(Icons.shopping_cart, color: Colors.white),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Avatar + Name
                    Row(
                      children: [
                        const CircleAvatar(radius: 30),
                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.location,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔢 Stats Card
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(user.ongoing, "Ongoing"),
                  _buildStat(user.delivery, "Delivery"),
                  _buildStat(user.complete, "Complete"),
                ],
              ),
            ),
          ),

          // 📋 Menu List
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              child: ListView(
                children: [
                  const ProfileTile(
                    icon: Icons.history,
                    title: "Order History",
                    iconColor: Colors.black54,
                  ),
                  const ProfileTile(
                    icon: Icons.payment,
                    title: "Payment Method",
                    iconColor: Colors.black54,
                  ),
                  const ProfileTile(
                    icon: Icons.location_on,
                    title: "My Address",
                    iconColor: Colors.black54,
                  ),
                  const ProfileTile(
                    icon: Icons.favorite,
                    title: "My Favorite",
                    iconColor: Colors.black54,
                  ),
                  InkWell(
                    onTap: () {
                      SignOutDialog();
                    },
                    child: const ProfileTile(
                      icon: Icons.info,
                      title: "About Us",
                      iconColor: Colors.black54,
                    ),
                  ),
                  InkWell(
                    onTap: () => SignOutDialog.show(),
                    child: const ProfileTile(
                      icon: Icons.logout,
                      title: "Sign Out",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(int value, String label) {
    return Column(
      children: [
        Text(
          "$value",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class ProfileData {
  static UserProfile user = UserProfile(
    name: "Ericsn Combs",
    location: "Maple Ave, New York",
    image: "",
    ongoing: 14,
    delivery: 25,
    complete: 16,
  );
}
