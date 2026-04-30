import 'package:flutter/material.dart';

import '../../component/customCircleAvator/customCircleavators.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    AppResponsive().init(context); // Responsive init

    return Scaffold(
      backgroundColor: const Color(0xFF1B5E20), // Green Background
      body: Stack(
        children: [
          // --- Upper Right Background Design ---
          Positioned(
            top: 20,
            right: -30,
            child: BackgroundCircle(size: 150, color: Colors.yellow.shade700),
          ),
          Positioned(
            top: 80,
            right: -50,
            child: BackgroundCircle(size: 180, color: Colors.yellow.shade600),
          ),
          // Thick White Line Circle (Upper Right)
          Positioned(
            top: 40,
            right: -20,
            child: const BackgroundCircle(size: 200, color: Colors.transparent, hasBorder: true),
          ),

          // --- Lower Left Background Design ---
          Positioned(
            bottom: -40,
            left: -20,
            child: BackgroundCircle(size: 160, color: Colors.yellow.shade700),
          ),
          // Thick White Line Circle (Lower Left)
          Positioned(
            bottom: -20,
            left: -10,
            child: const BackgroundCircle(size: 180, color: Colors.transparent, hasBorder: true),
          ),

          // --- UI Content ---
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return OnboardingContent(
                title: "MadeFork Screen ${index + 1}",
                description: "Clean, responsive UI with custom designs.",
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, description;
  const OnboardingContent({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          // Aapka image ya illustration yahan aayega
          const FlutterLogo(size: 150),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: AppResponsive.width(8), // Responsive text
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.width(4.5),
              color: Colors.white70,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}