import 'package:flutter/material.dart';

class APPResponsive {
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
  static double fs(double percent, {double? min, double? max}) {
    double size = screenWidth * (percent / 100);

    if (min != null && size < min) return min;
    if (max != null && size > max) return max;

    return size;
  }
}

extension ResponsiveContext on BuildContext {
  double rH(double percent) => APPResponsive.height(percent);
  double rW(double percent) => APPResponsive.width(percent);
}
