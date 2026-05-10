import 'package:flutter/material.dart';
import 'package:madeforke_app/view/resturentOwnerside/botomnavigation/bottomnavgation.dart';
import 'package:madeforke_app/view/screens/bottomNavigationBar/bottomNavgationBar.dart';
import 'package:madeforke_app/view/screens/splashScreen/splashScreen.dart';

import 'apipraice/apipractice.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  home:
  MainScreenowneside()
      //OtpScreen()
  //SplashScreen(),
    );
  }
}

