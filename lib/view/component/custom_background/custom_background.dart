import 'package:flutter/material.dart';
import '../../utils/costsColors/constColors.dart';
import '../customCircleAvator/customCircleavators.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: -280,
            right: -15,
            child: BackgroundCircle(
              size: 500,
              color: AppColor.backgroundYellow,
            ),
          ),
          Positioned(
            top: -300,
            left: -100,
            child: BackgroundCircle(size: 460, color: Colors.yellow.shade700),
          ),
          Positioned(
            top: -200,
            left: -50,
            child: const BackgroundCircle(
              size: 400,
              color: Colors.transparent,
              hasBorder: true,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
