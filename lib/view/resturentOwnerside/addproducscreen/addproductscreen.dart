import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, size: 20),
        title: const Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Save", style: TextStyle(color: Colors.orange, fontSize: 16)))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Image", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            //image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey.shade400),
                  const Text("Tap to upload image", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("JPG, PNG up to 5MB", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //name
            _buildTextField("Product Name", "Enter product name"),
            const SizedBox(height: 15),
            //price  & category
            Row(
              children: [
                //price
                Expanded(child: _buildTextField("Price", "\$ 0.00")),
                const SizedBox(width: 15),
                //category
                Expanded(child: _buildTextField("Category", "Select category", isDropdown: true)),
              ],
            ),
            const SizedBox(height: 15),
            //sizes
            const Text("Sizes", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: ["S", "M", "L", "XL", "Custom"].map((size) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: size == "S" ? Colors.orange : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: size == "M" ? Colors.orange.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Text(size, style: TextStyle(color: size == "M" ? Colors.orange : Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),

            //description
            _buildTextField("Description", "Enter product description", maxLines: 3),
            const SizedBox(height: 30),

           // uplod ya add button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Add Product", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, bool isDropdown = true}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    const SizedBox(height: 8),
    TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
    hintText: hint,
    suffixIcon: isDropdown ? const Icon(Icons.keyboard_arrow_down) : null,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),

    )

    ),
    ],
    );
  }
}