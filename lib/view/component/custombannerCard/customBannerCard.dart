import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';

class BannerCard extends StatelessWidget {
  final String title, sub, discount, imageUrl;
  final Color bgColor;

  const BannerCard({
    super.key,
    required this.title,
    required this.sub,
    required this.discount,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.rW(4)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.rW(4)),
      ),
      child: Row(
        children: [
          // Left text
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(context.rW(3.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sub,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: APPResponsive.fs(2.8, min: 10, max: 13),
                    ),
                  ),
                  SizedBox(height: context.rH(0.5)),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: APPResponsive.fs(3.5, min: 12, max: 17),
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Discount badge
          Container(
            margin: EdgeInsets.symmetric(vertical: context.rH(1.5)),
            padding: EdgeInsets.symmetric(
              horizontal: context.rW(2.5),
              vertical: context.rH(0.8),
            ),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(context.rW(2.5)),
            ),
            child: Text(
              discount,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: APPResponsive.fs(3.2, min: 11, max: 15),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // Food image
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(context.rW(4)),
                bottomRight: Radius.circular(context.rW(4)),
              ),
              child: Image.network(
                imageUrl,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.white24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}