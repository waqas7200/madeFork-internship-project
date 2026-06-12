// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/auth_Cntroller/auth_Controller.dart';
//
// class SignOutDialog extends StatelessWidget {
//   const SignOutDialog({super.key});
//
//   // Static method — aasani se call karo kahin se bhi
//   static void show() {
//     Get.dialog(
//       const SignOutDialog(),
//       barrierDismissible: true,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Icon
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.logout_rounded,
//                 color: Colors.red.shade400,
//                 size: 32,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Title
//             const Text(
//               "Sign Out",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // Message
//             const Text(
//               "Kya aap waqai sign out karna chahte hain?",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Buttons
//             Row(
//               children: [
//                 // Cancel button
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Get.back(),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text("Cancel"),
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 // Sign Out button
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.back(); // Dialog band karo
//                       // Apna controller call karo
//                       AuthController.instance.logout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red.shade400,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text("Sign Out"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_Cntroller/auth_Controller.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  static void show() {
    Get.dialog(const SignOutDialog(), barrierDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade400,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Sign Out",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "are you sure to Sign Out?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.find<AuthController>().logout(); // ✅ Fix
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Sign Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
