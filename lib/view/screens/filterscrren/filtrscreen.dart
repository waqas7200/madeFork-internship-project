import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_routes.dart';

import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';
import '../trackingorderscreen/trackingorderscreen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String sortBy = "Top Rated";
  String orderType = "Delivery";

  RangeValues priceRange = const RangeValues(0, 125);

  bool payByCard = true;
  bool discount = true;
  bool preOrder = false;

  final Color primaryColor = const Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Filter",
          style: TextStyle(color: Colors.black, fontSize: context.rH(2.2)),
        ),
        actions: [
          Icon(Icons.shopping_cart, color: Colors.black, size: context.rH(2.5)),
          SizedBox(width: APPResponsive.fs(2)),
          CircleAvatar(radius: context.rH(2)),
          SizedBox(width: context.rW(3)),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
          child: ListView(
            children: [
              SizedBox(height: context.rH(2)),

              // 🔹 Sort By
              buildTitle("Sort By"),
              buildRadio("Top Rated"),
              buildRadio("Nearest Me"),
              buildRadio("High Price"),
              buildRadio("Low Price"),

              SizedBox(height: context.rH(2.5)),

              // 🔹 Order Type
              buildTitle("Order Type"),
              SizedBox(height: context.rH(1.5)),
              Row(
                children: [
                  buildOrderCard("Delivery", "\$13", Icons.delivery_dining),
                  SizedBox(width: context.rW(3)),
                  buildOrderCard("Pickup", "Free", Icons.store),
                ],
              ),

              SizedBox(height: context.rH(2.5)),

              // 🔹 Price Range
              buildTitle("Price Range"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${priceRange.start.toInt()}"),
                  Text("\$${priceRange.end.toInt()}"),
                ],
              ),

              RangeSlider(
                values: priceRange,
                min: 0,
                max: 125,
                activeColor: primaryColor,
                onChanged: (values) {
                  setState(() => priceRange = values);
                },
              ),
              SizedBox(height: context.rH(2)),
              buildTitle("Sort By"),
              SizedBox(height: context.rH(2)),

              // 🔹 Switches
              buildSwitch("Pay by credit card", payByCard, (val) {
                setState(() => payByCard = val);
              }),
              buildSwitch("Discount Price", discount, (val) {
                setState(() => discount = val);
              }),
              buildSwitch("Pre Order", preOrder, (val) {
                setState(() => preOrder = val);
              }),

              SizedBox(height: context.rH(3)),

              // 🔘 Button
              SizedBox(
                height: context.rH(7),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.rH(3)),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.trackOrder);
                  },
                  child: Text(
                    "Search (23)",
                    style: TextStyle(fontSize: context.rH(2)),
                  ),
                ),
              ),

              SizedBox(height: context.rH(2)),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Title
  Widget buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: context.rH(2), fontWeight: FontWeight.bold),
    );
  }
  //
  // // 🔹 Radio
  // Widget buildRadio(String title) {
  //   return RadioListTile(
  //     value: title,
  //     groupValue: sortBy,
  //     activeColor: primaryColor,
  //     title: Text(title),
  //     onChanged: (value) {
  //       setState(() => sortBy = value!);
  //     },
  //   );
  // }

  Widget buildRadio(String title, {bool showDivider = true}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => sortBy = title);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.rH(1.5)),
            child: Row(
              children: [
                // 🔹 Title Left
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.rH(1.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // 🔘 Radio Right
                Radio(
                  value: title,
                  groupValue: sortBy,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    setState(() => sortBy = value!);
                  },
                ),
              ],
            ),
          ),
        ),

        // 🔻 Underline / Divider
        if (showDivider)
          Divider(height: 0, thickness: 0.8, color: Colors.grey.shade300),
      ],
    );
  }

  // 🔹 Order Card
  Widget buildOrderCard(String title, String price, IconData icon) {
    bool isSelected = orderType == title;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => orderType = title),
        child: Container(
          padding: EdgeInsets.all(context.rH(1.5)),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(context.rH(1.5)),
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryColor, size: context.rH(3)),
              SizedBox(height: context.rH(1)),
              Text(title),
              Text(price, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Switch
  Widget buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      value: value,
      activeColor: primaryColor,
      title: Text(title),
      onChanged: onChanged,
    );
  }
}
