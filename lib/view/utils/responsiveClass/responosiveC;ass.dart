import 'package:flutter/material.dart';

class AppResponsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  // Percentage based width/height for responsiveness
  static double width(double percent) => screenWidth * (percent / 100);
  static double height(double percent) => screenHeight * (percent / 100);
}