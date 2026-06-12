import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:madeforke_app/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late AnimationController _textCtrl;
  late AnimationController _rippleCtrl;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _ripple;

  nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = CurvedAnimation(
      parent: _logoCtrl,
      curve: Curves.elasticOut,
    ).drive(Tween(begin: 0.5, end: 1.0));
    _logoOpacity = CurvedAnimation(
      parent: _logoCtrl,
      curve: Curves.easeIn,
    ).drive(Tween(begin: 0.0, end: 1.0));

    // Text animation
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textSlide = CurvedAnimation(
      parent: _textCtrl,
      curve: Curves.easeOutBack,
    ).drive(Tween(begin: const Offset(0, 0.6), end: Offset.zero));
    _textOpacity = _textCtrl.drive(Tween(begin: 0.0, end: 1.0));

    // Ripple animation
    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
    _ripple = _rippleCtrl.drive(Tween(begin: 0.0, end: 1.0));

    // Start sequence
    _logoCtrl.forward();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => _textCtrl.forward(),
    );

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        // User already logged in -> Go to MainScreen
        Get.offAllNamed(AppRoutes.main);
      } else {
        // Guest user -> Go to OnboardingScreen
        Get.offAllNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _rippleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundBlue,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Ripple rings
          AnimatedBuilder(
            animation: _ripple,
            builder: (_, __) => _buildRipple(_ripple.value, 0),
          ),
          AnimatedBuilder(
            animation: _ripple,
            builder: (_, __) => _buildRipple((_ripple.value + 0.33) % 1, 0),
          ),
          AnimatedBuilder(
            animation: _ripple,
            builder: (_, __) => _buildRipple((_ripple.value + 0.66) % 1, 0),
          ),

          // Center content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              ScaleTransition(
                scale: _logoScale,
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: Image.asset(
                    'assets/splash_Icon/Logo.png',
                    width: 170,
                    height: 170,
                  ),
                ),
              ),

              // const SizedBox(height: 20),
              //
              // // Text block
              // SlideTransition(
              //   position: _textSlide,
              //   child: FadeTransition(
              //     opacity: _textOpacity,
              //     child: Column(
              //       children: [
              //         Text(
              //           'MadeFork',
              //           style: TextStyle(
              //             fontSize: 36,
              //             fontWeight: FontWeight.w700,
              //             color:AppColor.backgroundYellow,
              //             letterSpacing: 1.5,
              //             fontFamily: 'Georgia',
              //           ),
              //         ),
              //         const SizedBox(height: 6),
              //         const Text(
              //           'Food Restaurant',
              //           style: TextStyle(
              //             fontSize: 13,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.white,
              //             letterSpacing: 4,
              //             fontFamily: 'Georgia',
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 50),

              // Loading dots
              FadeTransition(
                opacity: _textOpacity,
                child: const _LoadingDots(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRipple(double value, double delay) {
    return Container(
      width: 300 + (value * 300),
      height: 300 + (value * 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD4891A).withOpacity(0.25 * (1 - value)),
          width: 1.5,
        ),
      ),
    );
  }
}

// Pulsing dots widget
class _LoadingDots extends StatefulWidget {
  const _LoadingDots();
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with TickerProviderStateMixin {
  final List<AnimationController> _ctrls = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      );
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) c.repeat(reverse: true);
      });
      _ctrls.add(c);
    }
  }

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _ctrls[i],
          builder: (_, __) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 7 + (_ctrls[i].value * 3),
            height: 7 + (_ctrls[i].value * 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(
                0xFFD4891A,
              ).withOpacity(0.3 + (_ctrls[i].value * 0.7)),
            ),
          ),
        );
      }),
    );
  }
}
