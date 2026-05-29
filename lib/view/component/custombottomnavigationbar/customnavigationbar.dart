


// ─────────────────────────────────────────────
//  BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/bottomNavigationBar/bottomNavgationBar.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_rounded,          'label': 'Home'},
    {'icon': Icons.receipt_long_outlined, 'label': 'Orders'},
    {'icon': Icons.chat_bubble_outline,   'label': 'Chat'},
    {'icon': Icons.person_outline,        'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);
    final iconSize = context.rW(6).clamp(20.0, 28.0);
    final labelSize = APPResponsive.fs(2.5, min: 9, max: 13);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.rH(1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (i) {
              final item = _navItems[i];
              final isSelected = currentIndex == i;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.rW(4),
                    vertical: context.rH(0.7),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF00897B).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(context.rW(5)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isSelected
                            ? const Color(0xFF00897B)
                            : Colors.grey.shade400,
                        size: iconSize,
                      ),
                      SizedBox(height: context.rH(0.3)),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: labelSize,
                          color: isSelected
                              ? const Color(0xFF00897B)
                              : Colors.grey.shade400,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}