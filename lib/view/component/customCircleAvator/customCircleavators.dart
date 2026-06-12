import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundCircle extends StatelessWidget {
  final double size;
  final Color color;
  final bool hasBorder;

  const BackgroundCircle({
    super.key,
    required this.size,
    required this.color,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasBorder ? Colors.transparent : color,
        border: hasBorder
            ? Border.all(color: Colors.white.withOpacity(0.5), width: 8)
            : null,
      ),
    );
  }
}
