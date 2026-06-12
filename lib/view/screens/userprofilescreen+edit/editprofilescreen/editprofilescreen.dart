import 'package:flutter/material.dart';

import 'congratulationdilogscreen/congratulationdilogscreen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile", style: TextStyle(color: Colors.white)),
              Icon(Icons.shopping_cart, color: Colors.white),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🔶 Header
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // 👤 Avatar
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 125),
            child: CircleAvatar(
              radius: 60,
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 📝 Fields
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 0),
            child: Column(
              children: [
                _buildField("Joe yashi", "Full Name"),
                _buildField("joe@gmail.com", "E-mail"),
                _buildField("(92)3301234567", "Mobile Phone"),
                _buildField("male", "Gender"),
              ],
            ),
          ),

          // 🔘 Button
          Padding(
            padding: const EdgeInsets.only(top: 520, left: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // showCongratsDialog(context);
                showVipCongratsDialog(context);
              },
              child: const Text(
                "Update Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildField(String hint, uperhint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              uperhint,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
