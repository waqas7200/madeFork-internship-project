// import 'package:flutter/material.dart';
//
// void showCongratsDialog(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "Congrats",
//     transitionDuration: const Duration(milliseconds: 500),
//     pageBuilder: (context, anim1, anim2) {
//       return const Center(child: CongratsDialog());
//     },
//     transitionBuilder: (context, anim, secondaryAnim, child) {
//       return FadeTransition(
//         opacity: anim,
//         child: ScaleTransition(
//           scale: CurvedAnimation(
//             parent: anim,
//             curve: Curves.elasticOut,
//           ),
//           child: child,
//         ),
//       );
//     },
//   );
// }
//
// class CongratsDialog extends StatefulWidget {
//   const CongratsDialog({super.key});
//
//   @override
//   State<CongratsDialog> createState() => _CongratsDialogState();
// }
//
// class _CongratsDialogState extends State<CongratsDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..forward();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black54,
//       child: Center(
//         child: Container(
//           width: 280,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: _controller,
//                   curve: Curves.elasticOut,
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade100,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.check,
//                       size: 50, color: Colors.green),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text("Congratulations!!",
//                   style: TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               const Text(
//                 "You successfully updated your profile",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 20),
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.close),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';

void showVipCongratsDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "VIP",
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (_, __, ___) => const VipCongratsDialog(),
    transitionBuilder: (context, anim, _, child) {
      return FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutBack,
          ),
          child: child,
        ),
      );
    },
  );
}

class VipCongratsDialog extends StatefulWidget {
  const VipCongratsDialog({super.key});

  @override
  State<VipCongratsDialog> createState() => _VipCongratsDialogState();
}

class _VipCongratsDialogState extends State<VipCongratsDialog>
    with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    // Haptic Feedback
    HapticFeedback.mediumImpact();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.orange,
              Colors.blue,
              Colors.pink
            ],
          ),

          // Glassmorphism Background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Dialog
          FadeTransition(
            opacity: _fadeController,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie Animation
                  Lottie.network(
                    "https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json",
                    height: 120,
                    repeat: false,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Congratulations 🎉",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Your profile has been successfully updated!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Done"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}