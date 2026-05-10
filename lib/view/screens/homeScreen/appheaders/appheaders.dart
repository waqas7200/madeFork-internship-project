
// ─────────────────────────────────────────────
//  HEADER
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bottomNavigationBar/bottomNavgationBar.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: context.rW(4),
        vertical: context.rH(1.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the taste',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: context.fs(3.2, min: 11, max: 15),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'of Asian Food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.fs(4.5, min: 15, max: 22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: context.rW(6).clamp(20, 30),
              ),
              SizedBox(width: context.rW(3)),
              CircleAvatar(
                radius: context.rW(5).clamp(18, 26),
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?img=47',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
