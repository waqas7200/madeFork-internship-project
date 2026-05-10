import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../addproducscreen/addproductscreen.dart';
import '../myproductscreen/myproductscreen.dart';
import '../ownerDashbordscreen/ownerdashbordscreen.dart';

class MainScreenowneside extends StatefulWidget {
  @override
  State<MainScreenowneside> createState() => _MainScreenownesideState();
}

class _MainScreenownesideState extends State<MainScreenowneside> {
  int index = 0;

  final screens = [
    OwnerDashboardScreen(),
    MyProductsScreen(),
    AddProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.orange,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
        ],
      ),
    );
  }
}