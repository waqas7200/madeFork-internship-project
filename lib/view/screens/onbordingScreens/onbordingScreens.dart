// import 'package:flutter/material.dart';
// import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
//
// import '../../component/customCircleAvator/customCircleavators.dart';
// import '../../utils/responsiveClass/responosiveC;ass.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     AppResponsive().init(context); // Responsive init
//
//     return Scaffold(
//       backgroundColor:AppColor.backgroundBlue , // Green Background
//       body: Stack(
//         children: [
//           // --- Upper Right Background Design ---
//           Positioned(
//             top:-280,
//             right: -15,
//             child: BackgroundCircle(size: 500, color:AppColor.backgroundYellow),
//           ),
//           Positioned(
//             top: -300,
//             left: -100,
//             child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
//           ),
//           // Thick White Line Circle (Upper Right)
//           Positioned(
//             top:-200,
//             left: -50,
//             child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
//           ),
//
//           // --- Lower Left Background Design ---
//           Positioned(
//             bottom: -230,
//             left: -40,
//             child: BackgroundCircle(size: 450, color: Colors.yellow.shade700),
//           ),
//           // Thick White Line Circle (Lower Left)
//           Positioned(
//             bottom: -250,
//             right: -180,
//             child: const BackgroundCircle(size: 580, color: Colors.transparent, hasBorder: true),
//           ),
//
//           // --- UI Content ---
//           PageView.builder(
//             controller: _pageController,
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return OnboardingContent(
//                 title: "MadeFork Screen ${index + 1}",
//                 description: "Clean, responsive UI with custom designs.",
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OnboardingContent extends StatelessWidget {
//   final String title, description;
//   const OnboardingContent({super.key, required this.title, required this.description});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Spacer(flex: 3),
//           // Aapka image ya illustration yahan aayega
//           const FlutterLogo(size: 150),
//           const Spacer(),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: AppResponsive.width(8), // Responsive text
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: AppResponsive.width(4.5),
//               color: Colors.white70,
//             ),
//           ),
//           const Spacer(flex: 2),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

import '../../component/customCircleAvator/customCircleavators.dart';
import '../../component/onbordinfg_Custom/onboding-custom.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../auth_screens/login_screen/Login_scren.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      },
    {
       },
    {
       },
  ];

  void _onButtonPressed() {
    if (_currentPage < _pages.length - 1) {
      // Next page par jao
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page par Login screen par jao
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // 👈 body AppBar ke peeche se shuru hogi

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, // 👈 scroll par bhi background na aaye
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color:AppColor.textBlack,
                fontSize: AppResponsive.width(4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.backgroundBlue,
      body: Stack(
        children: [


          // --- Upper Right Background Design ---
          Positioned(
            top: -280,
            right: -15,
            child: BackgroundCircle(size: 500, color: AppColor.backgroundYellow),
          ),
          Positioned(
            top: -300,
            left: -100,
            child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
          ),
          Positioned(
            top: -200,
            left: -50,
            child: const BackgroundCircle(size: 400, color: Colors.transparent, hasBorder: true),
          ),

          //app images and name
          Positioned(
            top: AppResponsive.height(7), // AppBar ke neeche
            left: AppResponsive.width(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo / Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:AppColor.backgroundBlue,
                  ),

                  child: Image.asset(
                    'assets/splash_Icon/Logo.png', // apni image path yahan
                    width: AppResponsive.width(16),
                    height: AppResponsive.width(20),
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(width: 10),

                // App Name Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "MadeFork",
                      style: TextStyle(
                        fontSize: AppResponsive.width(5),
                        fontWeight: FontWeight.bold,
                        color: AppColor.backgroundBlue,
                      ),
                    ),
                    Text(
                      "Food & Restaurant",
                      style: TextStyle(
                        fontSize: AppResponsive.width(3),
                        color: AppColor.backgroundBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- Lower Left Background Design ---
          Positioned(
            bottom: -230,
            left: -40,
            child: BackgroundCircle(size: 450, color: Colors.yellow.shade700),
          ),
          Positioned(
            bottom: -250,
            right: -180,
            child: const BackgroundCircle(size: 580, color: Colors.transparent, hasBorder: true),
          ),

          // --- Page View ---
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == 0) return const OnboardingPage1();
              if (index == 1) return const OnboardingPage2();
              return const OnboardingPage3();
            },
          ),

          // --- Dots + Button neeche ---
          Positioned(
            bottom: AppResponsive.height(6),
            left: AppResponsive.width(10),
            right: AppResponsive.width(10),
            child: Column(
              children: [
                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (index) {
                    bool isSelected = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: isSelected ? 14 : 8,
                      height: isSelected ? 14 : 8,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Get Started Button
                SizedBox(
                  width: double.infinity,
                  height: AppResponsive.height(7),
                  child: ElevatedButton(
                    onPressed: _onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppResponsive.width(4)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? "Login" : "Get Started",
                      style: TextStyle(
                        fontSize: AppResponsive.width(4.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0; // 👈 current page track karne ke liye
//
//   // 👇 Teen screens ka data
//   final List<Map<String, String>> _pages = [
//     {
//       "title": "Welcome to MadeFork",
//       "description": "Discover the best food experience tailored just for you.",
//       "image":"assets/onbrding-screen-pics/img.png",
//     },
//     {
//       "title": "Explore Restaurants",
//       "description": "Browse hundreds of restaurants and cuisines near you.",
//       "image":"assets/onbrding-screen-pics/img.png",
//     },
//     {
//       "title": "Fast Delivery",
//       "description": "Get your favorite meals delivered fresh and fast.",
//       "image":"assets/onbrding-screen-pics/img_1.png",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     AppResponsive().init(context);
//
//     return Scaffold(
//       backgroundColor: AppColor.backgroundBlue,
//       body: Stack(
//         children: [
//           // --- Upper Right Background Design ---
//           Positioned(
//             top: -220,
//             right: 20,
//             child: BackgroundCircle(size: 530, color: AppColor.backgroundYellow),
//           ),
//           Positioned(
//             top: -230,
//             left: -30,
//             child: BackgroundCircle(size: 480, color: Colors.yellow.shade700),
//           ),
//           Positioned(
//             top: -240,
//             left: -80,
//             child: const BackgroundCircle(size: 500, color: Colors.transparent, hasBorder: true),
//           ),
//
//           // --- Lower Left Background Design ---
//           Positioned(
//             bottom: -150,
//             left: -40,
//             child: BackgroundCircle(size: 500, color: Colors.yellow.shade700),
//           ),
//           Positioned(
//             bottom: -250,
//             right: -180,
//             child: const BackgroundCircle(size: 580, color: Colors.transparent, hasBorder: true),
//           ),
//
//           // --- Page View ---
//           PageView.builder(
//             controller: _pageController,
//             itemCount: _pages.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index; // 👈 page change hone par update
//               });
//             },
//             itemBuilder: (context, index) {
//               if (index == 0) return const OnboardingPage1();
//               if (index == 1) return const OnboardingPage2();
//               return const OnboardingPage3();
//             },
//           ),
//
//           // --- Page Indicator Dots (neeche center mein) ---
//           Positioned(
//             bottom: AppResponsive.height(18), // screen ke neeche se thoda upar
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_pages.length, (index) {
//                 bool isSelected = index == _currentPage;
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   margin: const EdgeInsets.symmetric(horizontal: 5),
//                   width: isSelected ? 30 : 8,   // 👈 selected dot thoda bada
//                   height: isSelected ? 20 : 8,
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? Colors.black        // selected = full black
//                         : Colors.black87, // unselected = grey
//                     shape: BoxShape.circle,
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

