
// ─────────────────────────────────────────────
//  AUTO-SWIPE BANNER SLIDER
// ─────────────────────────────────────────────
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/custombannerCard/customBannerCard.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  static const List<Map<String, String>> _banners = [
    {
      'title': "Eat gelato like\nthere's no tomorrow!",
      'sub': 'Hello! Luke Thomp',
      'discount': '50%\nAll Items',
      'image': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400',
      'bg': '0xFF00897B',
    },
    {
      'title': 'Fresh burgers\ndelivered fast!',
      'sub': 'Hello! Sarah K.',
      'discount': '30%\nBurgers',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'bg': '0xFFE65100',
    },
    {
      'title': 'Sweet drinks\nfor sweet moments',
      'sub': 'Hello! John D.',
      'discount': '20%\nDrinks',
      'image': 'https://images.unsplash.com/photo-1437418747212-8d9709afab22?w=400',
      'bg': '0xFF1565C0',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentPage + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerH = context.rH(18).clamp(130.0, 200.0);
    return Column(
      children: [
        SizedBox(
          height: bannerH,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) {
              final b = _banners[i];
              return BannerCard(
                title: b['title']!,
                sub: b['sub']!,
                discount: b['discount']!,
                imageUrl: b['image']!,
                bgColor: Color(int.parse(b['bg']!)),
              );
            },
          ),
        ),
        SizedBox(height: context.rH(1)),
        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: context.rW(0.8)),
              width: _currentPage == i ? context.rW(5) : context.rW(1.8),
              height: context.rH(0.9).clamp(6, 10),
              decoration: BoxDecoration(
                color: _currentPage == i
                    ? const Color(0xFF00897B)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}


