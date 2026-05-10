import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../component/ustomButton/customButton.dart';
import '../../../utils/costsColors/constColors.dart';
import '../../../utils/responsiveClass/responosiveC;ass.dart';


class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  // 4 OTP box controllers & focus nodes
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otpCode =>
      _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.backgroundBlue,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundBlue,
        elevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            color:  Colors.white,
            size: AppResponsive.width(6.5),
          ),
        ),
        title: Text(
          'OTP Verification',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppResponsive.height(6)),

              // Shield icon
              Container(
                width: AppResponsive.width(22),
                height: AppResponsive.width(22),
                decoration: BoxDecoration(
                  color: AppColor.backgroundYellow.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.checkmark_shield,
                  size: AppResponsive.width(10),
                  color: AppColor.backgroundYellow,
                ),
              ),

              SizedBox(height: AppResponsive.height(3)),

              // Heading
              Text(
                'Enter Your OTP Here',
                style: TextStyle(
                  fontSize: AppResponsive.width(5.5),
                  fontWeight: FontWeight.w800,
                  color:  Colors.white,
                ),
              ),

              SizedBox(height: AppResponsive.height(1.5)),

              // Sub text
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.width(4),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: AppResponsive.width(3.5),
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'We sent a 4-digit OTP to\n'),
                      TextSpan(
                        text: widget.email,
                        style: TextStyle(
                          color: AppColor.backgroundYellow,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppResponsive.height(5)),

              // OTP Boxes Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: AppResponsive.width(14),
                    height: AppResponsive.width(14),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppResponsive.width(2),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                      BorderRadius.circular(AppResponsive.width(3)),
                      border: Border.all(
                        color: _focusNodes[index].hasFocus
                            ? AppColor.backgroundYellow
                            : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: AppResponsive.width(5.5),
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) => _onOtpChanged(value, index),
                      onTap: () => setState(() {}),
                    ),
                  );
                }),
              ),

              SizedBox(height: AppResponsive.height(5)),

              // Send / Verify Button
              CustomButton(
                // label: 'Send',
                onPressed: () {
                  if (_otpCode.length == 4) {
                    // Handle OTP verification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP Verified: $_otpCode'),
                        backgroundColor: AppColor.backgroundYellow,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter complete OTP'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }, text: 'Send',
                isLoading: _isLoading,
              ),

              SizedBox(height: AppResponsive.height(3)),

              // Resend OTP text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't receive the OTP? ",
                    style: TextStyle(
                      fontSize: AppResponsive.width(3.6),
                      color: Colors.grey.shade500,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () {
                      // Resend OTP logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP Resent Successfully!'),
                        ),
                      );
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: AppResponsive.width(3.6),
                        color: AppColor.backgroundYellow,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppResponsive.height(3)),
            ],
          ),
        ),
      ),
    );
  }
}