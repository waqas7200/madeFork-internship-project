// ─────────────────────────────────────────────
//  SEARCH BAR
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(
        context.rW(4),
        0,
        context.rW(4),
        context.rH(2),
      ),
      child: TextField(
        style: TextStyle(fontSize: APPResponsive.fs(3.5, min: 12, max: 16)),
        decoration: InputDecoration(
          hintText: 'Search food, restaurants...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: APPResponsive.fs(3.3, min: 11, max: 15),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: context.rW(5).clamp(18, 24),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.tune,
              color: const Color(0xFF00897B),
              size: context.rW(5).clamp(18, 24),
            ),
            onPressed: () {},
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: context.rH(0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.rW(3)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
