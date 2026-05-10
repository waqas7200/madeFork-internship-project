


import 'package:flutter/cupertino.dart';

import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double itemSize;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: itemSize,
          height: itemSize,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(context.rW(4)),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: itemSize * 0.5),
        ),
        SizedBox(height: context.rH(0.6)),
        Text(
          label,
          style: TextStyle(
            fontSize: context.fs(2.8, min: 10, max: 14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
