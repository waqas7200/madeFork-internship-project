import 'package:flutter/material.dart';

import '../../../utils/costsColors/constColors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: const Text("About Us", style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Logo Card
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:AppColor.backgroundBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children:  [
                 Container(
                     height: 150,
                     width: 100,
                     child: Image(image: AssetImage('assets/splash_Icon/Logo.png'))),

                  Text("Version 1.0.0 - Copyright"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("About Us",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 10),

            const Text(
              "Our restaurant app is designed to make it easy for customers to discover and order from their favorite restaurants...",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            _buildTile("What's New?"),
            _buildTile("Terms Of Uses"),
            _buildTile("Privacy"),

            const Spacer(),

            const Text("Copyright © ericsnde.co 2023"),
          ],
        ),
      ),

    );
  }

  Widget _buildTile(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}