// import 'package:flutter/material.dart';
//
// import '../../../model/resturentmodels/resturentmodel/rsturentmodel.dart';
// import '../addproducscreen/addproductscreen.dart';
// import '../myproductscreen/myproductscreen.dart';
// import '../ownerDashbordscreen/ownerdashbordscreen.dart';
//
//
// class RestaurantOwnerApp extends StatelessWidget {
//   const RestaurantOwnerApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Restaurant Owner Dashboard',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFFFF6B35),
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//       ),
//       home: const DashboardWrapper(),
//     );
//   }
// }
//
// /// Wrapper widget to manage navigation between screens
// class DashboardWrapper extends StatefulWidget {
//   const DashboardWrapper({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardWrapper> createState() => _DashboardWrapperState();
// }
//
// class _DashboardWrapperState extends State<DashboardWrapper> {
//   late Restaurant _restaurant;
//   int _currentScreenIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeRestaurant();
//   }
//
//   /// Initialize demo restaurant data
//   void _initializeRestaurant() {
//     _restaurant = Restaurant(
//       id: 'rest_001',
//       name: 'Ali Restaurant',
//       ownerName: 'Ali Ahmed',
//       profileImage: 'assets/images/restaurant_profile.jpg',
//       totalProducts: 24,
//       totalOrders: 18,
//       totalSales: 245.50,
//     );
//   }
//
//   /// Handle navigation between screens
//   void _onBottomNavTapped(int index) {
//     setState(() {
//       _currentScreenIndex = index;
//     });
//   }
//
//   /// Get current screen based on index
//   Widget _getCurrentScreen() {
//     switch (_currentScreenIndex) {
//       case 0:
//         return OwnerDashboardScreen(restaurant: _restaurant);
//       case 1:
//         return const MyProductsScreen();
//       case 2:
//         return const Center(child: Text('Orders Screen'));
//       case 3:
//         return const Center(child: Text('Profile Screen'));
//       default:
//         return OwnerDashboardScreen(restaurant: _restaurant);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _getCurrentScreen(),
//       floatingActionButton: _currentScreenIndex == 1
//           ? FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddProductScreen(),
//             ),
//           );
//         },
//         backgroundColor: const Color(0xFFFF6B35),
//         child: const Icon(Icons.add),
//       )
//           : null,
//     );
//   }
// }