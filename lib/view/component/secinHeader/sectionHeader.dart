
// ─────────────────────────────────────────────
//  SECTION HEADER
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap; // 👈 Optional callback add kiya

  const SectionHeader({super.key, required this.title, required this.actionLabel,
    this.onActionTap, // 👈 Isko required nahi rakha taake ye optional rahe
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.fs(4, min: 14, max: 20),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: InkWell(
              onTap: onActionTap,
              child: Text(
                actionLabel,
                style: TextStyle(
                  fontSize: context.fs(3.2, min: 11, max: 15),
                  color: const Color(0xFF00897B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
