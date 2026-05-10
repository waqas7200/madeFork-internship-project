import 'package:flutter/material.dart';

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Owner Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_outlined)),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Orange Welcome Card ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome back,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          Text("Ali Restaurant", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network("https://images.unsplash.com/photo-1513104890138-7c749659a591", fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem("Total Products", "24"),
                      _buildStatItem("Total Orders", "18"),
                      _buildStatItem("Total Sales", "\$245.50"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // --- Quick Actions Grid ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 2.5,
              children: [
                _buildQuickAction(Icons.add_box_outlined, "Add Product", Colors.orange),
                _buildQuickAction(Icons. storefront_outlined, "My Products", Colors.green),
                _buildQuickAction(Icons.assignment_outlined, "Orders", Colors.blue),
                _buildQuickAction(Icons.grid_view_outlined, "Categories", Colors.purple),
              ],
            ),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text("See All", style: TextStyle(color: Colors.grey))),
              ],
            ),

            // --- Recent Orders List ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildOrderTile(index);
              },
            ),
          ],
        ),
      ),
      // --- Bottom Navigation Bar ---

    );
  }

  // Widget helper for Stats in Orange Card
  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Widget helper for Quick Action Buttons
  Widget _buildQuickAction(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  // Widget helper for Recent Order List Item
  Widget _buildOrderTile(int index) {
    List<String> names = ["Chicken Burger", "Chicken Pizza", "French Fries"];
    List<String> prices = ["\$12.50", "\$18.00", "\$5.00"];
    List<String> status = ["Pending", "Preparing", "Completed"];
    List<Color> statusColors = [Colors.orange, Colors.blue, Colors.green];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network("https://images.unsplash.com/photo-1513104890138-7c749659a591", width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("#ORD123${index + 4}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: statusColors[index].withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                  child: Text(status[index], style: TextStyle(color: statusColors[index], fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(prices[index], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              const Text("2 Items", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}