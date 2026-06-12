// import 'package:flutter/material.dart';
// import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
//
// class CustomSnackBar {
//   static void show(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(
//             fontStyle: FontStyle.italic, // Premium look ke liye
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: AppColor.backgroundYellow, // Deep Indigo / Blue tone
//         behavior: SnackBarBehavior.floating, // Is se modern look aati hai
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// class  CustomSnackBar{
//   static void showTopSnackBar(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 10, // Status bar ke neechay
//         left: 20,
//         right: 20,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               // Glassy Indigo Effect
//               color: const Color(0xFF1A237E).withOpacity(0.9),
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//               border: Border.all(color: Colors.white24),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.white, size: 20),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     message,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//
//     // Overlay add karna
//     overlay.insert(overlayEntry);
//
//     // 2-3 seconds baad remove kar dena
//     Future.delayed(const Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _TopSnackBarWidget(
        message: message,
        onDismissed: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const _TopSnackBarWidget({required this.message, required this.onDismissed});

  @override
  _TopSnackBarWidgetState createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Upar se neechay slide honay ki animation
    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack, // Thora bounce effect ke liye
          ),
        );

    _controller.forward();

    // 3 seconds baad wapis upar jaye aur remove ho jaye
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        await _controller.reverse();
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              // Glassy Modern Look
              color: AppColor.backgroundYellow.withOpacity(0.95),
              // const Color(0xFF1A237E)
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
