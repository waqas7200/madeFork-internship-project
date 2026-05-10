
// ========== PAGE 1 ==========
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

import '../../utils/responsiveClass/responosiveC;ass.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),

          // Image / Illustration
          Transform.rotate(
            angle: -0.35, // radian mein — thoda sa tilt
            child: Container(
              width: AppResponsive.width(50),
              height: AppResponsive.width(50),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/onbrding-screen-pics/img.png')),
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppResponsive.width(8)),
              ),
              
            ),
          ),

          const Spacer(),

          Text(
            "After a good dinner one \ncan forgive anybody even one's own relatives.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.width(6),
              fontWeight: FontWeight.bold,
              color: AppColor.textBlack,
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ========== PAGE 2 ==========
class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),

          // Image / Illustration

          Transform.rotate(
            angle: -0.35, // radian mein — thoda sa tilt
            child: Container(
              width: AppResponsive.width(50),
              height: AppResponsive.width(50),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/onbrding-screen-pics/img.png')),
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppResponsive.width(8)),
              ),

            ),
          ),



          const Spacer(),

          Text(
            "A recipe has no soul. You, as the cook,must bring the soul to recipe.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.width(6),
              fontWeight: FontWeight.bold,
              color: AppColor.textBlack,
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ========== PAGE 3 ==========
class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Transform.rotate(
            angle: -0.35, // radian mein — thoda sa tilt
            child: Container(
              width: AppResponsive.width(50),
              height: AppResponsive.width(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppResponsive.width(8)),
              ),child: const Icon(
              Icons.delivery_dining_rounded,
              size: 80,
              color: Colors.white,
            ),

            ),
          ),







          const Spacer(),

          Text(
            "A recipe has no soul. You, as the cook,must bring the soul to recipe.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.width(6),
              fontWeight: FontWeight.bold,
              color: AppColor.textBlack,
            ),
          ),


          const Spacer(flex: 2),
        ],
      ),
    );
  }
}