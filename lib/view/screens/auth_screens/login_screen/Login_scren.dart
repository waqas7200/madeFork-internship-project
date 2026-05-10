import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

import '../../../component/customTextformfelds/customTextfeilds.dart';
import '../../../component/ustomButton/customButton.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart' hide AppResponsive;
import '../../homeScreen/HomeScreen.dart';
import '../forgeScreen/forgetpasword_screen.dart';
import '../registerScreen/reisterScreen.dart';






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

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Home screen par jao
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive().init(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(7)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppResponsive.height(5)),

                // App Logo
                Center(
                  child: Image.asset(
                    'assets/splash_Icon/Logo.png',
                    width: AppResponsive.width(35),
                    height: AppResponsive.width(35),
                    fit: BoxFit.contain,
                  ),
                ),





                SizedBox(height: AppResponsive.height(4)),

                // Welcome Text
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: AppResponsive.width(6.5),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: AppResponsive.height(0.8)),

                Text(
                  "Login to your account to continue",
                  style: TextStyle(
                    fontSize: AppResponsive.width(3.8),
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: AppResponsive.height(3.5)),

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
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: AppResponsive.height(2.5)),

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

                SizedBox(height: AppResponsive.height(1.5)),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen()),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: AppResponsive.width(3.8),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppResponsive.height(4)),

                // Login Button
                CustomButton(
                  text: "Login",
                  isLoading: _isLoading,
                  onPressed: _onLogin,
                ),

                SizedBox(height: AppResponsive.height(3)),

                // Register Row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: AppResponsive.width(3.8),
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: AppResponsive.width(3.8),
                            color: AppColor.backgroundYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppResponsive.height(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


