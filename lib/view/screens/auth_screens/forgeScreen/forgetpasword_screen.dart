import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/customTextformfelds/customTextfeilds.dart';
import '../../../component/ustomButton/customButton.dart';
import '../../../utils/costsColors/constColors.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';
import '../otpSreen/otp_screen.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundBlue,
      appBar: AppBar(
        backgroundColor:AppColor.backgroundBlue,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
            size: AppResponsive.width(6.5),
          ),
        ),
        title: Text(
          'Forget Password',
          style: TextStyle(
            fontSize: AppResponsive.width(4.8),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.width(6),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppResponsive.height(6)),

                // Lock Icon
                Container(
                  width: AppResponsive.width(22),
                  height: AppResponsive.width(22),
                  decoration: BoxDecoration(
                    color: AppColor.backgroundBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.lock_shield,
                    size: AppResponsive.width(22),
                    color: AppColor.backgroundYellow,
                  ),
                ),

                SizedBox(height: AppResponsive.height(5)),

                // Forget Password heading
                Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: AppResponsive.width(6),
                    fontWeight: FontWeight.w800,
                    color:  Colors.white,
                  ),
                ),

                SizedBox(height: AppResponsive.height(1.5)),

                // Description text
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(4),
                  ),
                  child: Text(
                    'Don\'t worry! It happens. Please enter the email address linked with your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppResponsive.width(3.6),
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: AppResponsive.height(4)),

                // Email TextField
                CustomTextField(
                  hint: 'Enter your email',
                  controller: _emailController,
                  prefixIcon: CupertinoIcons.mail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: AppResponsive.height(4)),

                // Send OTP Button
                CustomButton(
                  // label: 'Send OTP',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpScreen(
                            email: _emailController.text.trim(),
                          ),
                        ),
                      );
                    }
                  }, text: 'Send',
                  isLoading: _isLoading ,
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