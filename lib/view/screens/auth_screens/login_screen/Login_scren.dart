import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:madeforke_app/utils/app_routes.dart';
import '../../../component/customTextformfelds/customTextfeilds.dart';
import '../../../component/ustomButton/customButton.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';

// ==================== LOGIN SCREEN ====================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final supabase = Supabase.instance.client;
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logged in successfully! Welcome back."),
              backgroundColor: Colors.green,
            ),
          );
          Get.offAllNamed(AppRoutes.main);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login Failed: ${e.toString()}"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: APPResponsive.height(5)),

                // App Logo
                Center(
                  child: Image.asset(
                    'assets/splash_Icon/Logo.png',
                    width: APPResponsive.width(35),
                    height: APPResponsive.width(35),
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: APPResponsive.height(4)),

                // Welcome Text
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: APPResponsive.width(6.5),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: APPResponsive.height(0.8)),

                Text(
                  "Login to your account to continue",
                  style: TextStyle(
                    fontSize: APPResponsive.width(3.8),
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: APPResponsive.height(3.5)),

                // Email Field
                CustomTextField(
                  // label: "Email",
                  hint: "Enter your email",
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(2.5)),

                // Password Field
                CustomTextField(
                  // label: "Password",
                  hint: "Enter your password",
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(1.5)),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: APPResponsive.width(3.8),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: APPResponsive.height(4)),

                // Login Button
                CustomButton(
                  text: "Login",
                  isLoading: _isLoading,
                  onPressed: _onLogin,
                ),

                SizedBox(height: APPResponsive.height(3)),

                // Register Row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: APPResponsive.width(3.8),
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: Text(
                          "Register Now",
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
