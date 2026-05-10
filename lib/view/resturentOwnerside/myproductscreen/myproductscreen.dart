import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("My Products", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          const Icon(Icons.search),
          const SizedBox(width: 15),
          Container(
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("All", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                Text("Active", style: TextStyle(color: Colors.grey)),
                Text("Inactive", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildProductItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://images.unsplash.com/photo-1513104890138-7c749659a591", // Placeholder image
              width: 80, height: 80, fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Chicken Pizza", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("Pizza", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 5),
                const Text("\$18.00", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(" 4.5 (120)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.more_vert, color: Colors.grey),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                child: const Text("Active", style: TextStyle(color: Colors.green, fontSize: 10)),
              )
            ],
          )
        ],
      ),
    );
  }
}