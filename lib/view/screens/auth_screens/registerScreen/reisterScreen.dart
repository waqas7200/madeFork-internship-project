// ==================== REGISTER SCREEN ====================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../component/customTextformfelds/customTextfeilds.dart';
import '../../../component/ustomButton/customButton.dart';
import '../../../utils/costsColors/constColors.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart' hide APPResponsive;
import '../../homeScreen/HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final supabase = Supabase.instance.client;
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          data: {
            'username': _usernameController.text.trim(),
          },
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Account created successfully! Welcome to MadeFork."),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration Failed: ${e.toString()}"),
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
      backgroundColor:  AppColor.backgroundBlue,
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
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: APPResponsive.height(3.5)),

                // Username Field
                CustomTextField(
                  // label: "Username",
                  hint: "Enter your username",
                  controller: _usernameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username required';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: APPResponsive.height(2.5)),

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

                SizedBox(height: APPResponsive.height(4)),

                // Register Button
                CustomButton(
                  text: "Register",
                  isLoading: _isLoading,
                  onPressed: _onRegister,
                ),

                SizedBox(height: APPResponsive.height(3)),

                // Login Row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: APPResponsive.width(3.8),
                          color: Colors.white
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
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