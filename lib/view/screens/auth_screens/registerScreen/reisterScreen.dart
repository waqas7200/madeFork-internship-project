//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/auth_Cntroller/auth_Controller.dart';
// import '../../../component/customTextformfelds/customTextfeilds.dart';
// import '../../../component/ustomButton/customButton.dart';
// import '../../../utils/costsColors/constColors.dart';
// import '../../../utils/responsiveClass/responosiveC;ass.dart';
//
//
// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final usernameController = TextEditingController();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final controller = Get.put(AuthController());
//
//     APPResponsive().init(context);
//
//     return Scaffold(
//       backgroundColor: AppColor.backgroundBlue,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: APPResponsive.width(7)),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: APPResponsive.height(5)),
//
//                 // // ── Logo ────────────────────────────────────────────────────
//                 // Center(
//                 //   child: Image.asset(
//                 //     'assets/splash_Icon/Logo.png',
//                 //     width: APPResponsive.width(30),
//                 //     height: APPResponsive.width(30),
//                 //     fit: BoxFit.contain,
//                 //   ),
//                 // ),
//                 //
//                  SizedBox(height: APPResponsive.height(3)),
//
//                 // ── Profile image picker ─────────────────────────────────────
//                 Center(
//                   child: Obx(() {
//                     final image = controller.selectedImage.value;
//                     return GestureDetector(
//                       onTap: controller.showImagePickerDialog,
//                       child: Stack(
//                         children: [
//                           Container(
//                             width: APPResponsive.width(43),
//                             height: APPResponsive.width(43),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white.withOpacity(0.15),
//                               border: Border.all(
//                                   color: Colors.white.withOpacity(0.5),
//                                   width: 2),
//                               image: image != null
//                                   ? DecorationImage(
//                                 image: FileImage(image),
//                                 fit: BoxFit.cover,
//                               )
//                                   : null,
//                             ),
//                             child: image == null
//                                 ? Icon(
//                               Icons.person_outline_rounded,
//                               size: APPResponsive.width(15),
//                               color: Colors.white.withOpacity(0.7),
//                             )
//                                 : null,
//                           ),
//                           Positioned(
//                             bottom: 25,
//                             right: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(6),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.camera_alt_rounded,
//                                 size: APPResponsive.width(4),
//                                 color: AppColor.backgroundBlue,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//
//                 SizedBox(height: APPResponsive.height(1.5)),
//
//                 Center(
//                   child: Text(
//                     "Add Profile Photo",
//                     style: TextStyle(
//                       fontSize: APPResponsive.width(3.2),
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: APPResponsive.height(3)),
//
//                 Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontSize: APPResponsive.width(6.5),
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//
//                 SizedBox(height: APPResponsive.height(0.8)),
//
//                 Text(
//                   "Register to get started",
//                   style: TextStyle(
//                     fontSize: APPResponsive.width(3.8),
//                     color: Colors.white.withOpacity(0.8),
//                   ),
//                 ),
//
//                 SizedBox(height: APPResponsive.height(3)),
//
//                 // ── Username ─────────────────────────────────────────────────
//                 CustomTextField(
//                   hint: "Enter your username",
//                   controller: usernameController,
//                   prefixIcon: Icons.person_outline,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Username required';
//                     if (value.length < 3) return 'Minimum 3 characters';
//                     return null;
//                   },
//                 ),
//
//                 SizedBox(height: APPResponsive.height(2.5)),
//
//                 // ── Email ────────────────────────────────────────────────────
//                 CustomTextField(
//                   hint: "Enter your email",
//                   controller: emailController,
//                   prefixIcon: Icons.email_outlined,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Email required';
//                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                         .hasMatch(value)) {
//                       return 'Enter valid email';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 SizedBox(height: APPResponsive.height(2.5)),
//
//                 // ── Password ─────────────────────────────────────────────────
//                 CustomTextField(
//                   hint: "Enter your password",
//                   controller: passwordController,
//                   prefixIcon: Icons.lock_outline,
//                   isPassword: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Password required';
//                     if (value.length < 6) return 'Minimum 6 characters';
//                     return null;
//                   },
//                 ),
//
//                 SizedBox(height: APPResponsive.height(4)),
//
//                 // ── Register button ──────────────────────────────────────────
//                 Obx(() => CustomButton(
//                   text: "Register",
//                   isLoading: controller.isLoading.value ||
//                       controller.isImageLoading.value,
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       controller.register(
//                         username: usernameController.text,
//                         email: emailController.text,
//                         password: passwordController.text,
//                       );
//                     }
//                   },
//                 )),
//
//                 SizedBox(height: APPResponsive.height(3)),
//
//                 // ── Login link ───────────────────────────────────────────────
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account? ",
//                         style: TextStyle(
//                           fontSize: APPResponsive.width(3.8),
//                           color: Colors.white,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => Get.back(),
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             fontSize: APPResponsive.width(3.8),
//                             color: AppColor.backgroundYellow,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: APPResponsive.height(3)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:madeforke_app/view/utils/app_Snakbar/ap_Snackbar.dart';
import '../../../../controller/auth_Cntroller/auth_Controller.dart';
import '../../../component/customTextformfelds/customTextfeilds.dart';
import '../../../component/ustomButton/customButton.dart';
import '../../../utils/costsColors/constColors.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ✅ Yahan define karo — sirf ek baar bante hain
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AuthController());
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: APPResponsive.width(7)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: APPResponsive.height(5)),
                SizedBox(height: APPResponsive.height(3)),

                // ── Profile image picker ──────────────────────────────────
                Center(
                  child: Obx(() {
                    final image = controller.selectedImage.value;
                    return GestureDetector(
                      onTap: controller.showImagePickerDialog,
                      child: Stack(
                        children: [
                          Container(
                            width: APPResponsive.width(43),
                            height: APPResponsive.width(43),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 2,
                              ),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: image == null
                                ? Icon(
                                    Icons.person_outline_rounded,
                                    size: APPResponsive.width(15),
                                    color: Colors.white.withOpacity(0.7),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 25,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: APPResponsive.width(4),
                                color: AppColor.backgroundBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                SizedBox(height: APPResponsive.height(1.5)),

                Center(
                  child: Text(
                    "Add Profile Photo",
                    style: TextStyle(
                      fontSize: APPResponsive.width(3.2),
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),

                SizedBox(height: APPResponsive.height(3)),

                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: APPResponsive.width(6.5),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: APPResponsive.height(0.8)),

                Text(
                  "Register to get started",
                  style: TextStyle(
                    fontSize: APPResponsive.width(3.8),
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),

                SizedBox(height: APPResponsive.height(3)),

                // ── Fields ───────────────────────────────────────────────
                CustomTextField(
                  hint: "Enter your username",
                  controller: usernameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Username required';
                    if (value.length < 3) return 'Minimum 3 characters';
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(2.5)),

                CustomTextField(
                  hint: "Enter your email",
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email required';
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value))
                      return 'Enter valid email';
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(2.5)),

                CustomTextField(
                  hint: "Enter your phone number",
                  controller: phoneController,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Phone number required';
                    if (value.length < 10) return 'Minimum 10 characters';
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(2.5)),

                CustomTextField(
                  hint: "Enter your password",
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password required';
                    if (value.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(4)),

                // ── Register button ───────────────────────────────────────
                Obx(
                  () => CustomButton(
                    text: "Register",
                    isLoading:
                        controller.isLoading.value ||
                        controller.isImageLoading.value,
                    onPressed: () {
                      if (controller.selectedImage.value == null) {
                        AppSnackbar.error(
                          "Please pick a profile image first.",
                          title: "Profile Image Required",
                        );
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        controller.register(
                          username: usernameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                ),

                SizedBox(height: APPResponsive.height(3)),

                // ── Login link ────────────────────────────────────────────
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: APPResponsive.width(3.8),
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: APPResponsive.width(3.8),
                            color: AppColor.backgroundYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: APPResponsive.height(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
