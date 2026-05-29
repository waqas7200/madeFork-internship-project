import 'package:flutter/material.dart';
import 'package:madeforke_app/view/screens/bottomNavigationBar/bottomNavgationBar.dart';
import 'package:madeforke_app/view/screens/splashScreen/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://omwgprcqjxyostiauhfm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9td2dwcmNxanh5b3N0aWF1aGZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg5ODgyODksImV4cCI6MjA5NDU2NDI4OX0.DitT6zikMHeTlJBJzw15Sl6ren6AN_NkK8_rlETPGZ0',
  );
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
  //MainScreen()
      //OtpScreen()
  SplashScreen(),
    );
  }
}

