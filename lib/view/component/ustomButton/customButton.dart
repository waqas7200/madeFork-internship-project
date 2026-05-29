import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/costsColors/constColors.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: APPResponsive.height(7),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.backgroundYellow,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(APPResponsive.width(3)),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
          width: APPResponsive.width(5),
          height: APPResponsive.width(5),
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : Text(
          text,
          style: TextStyle(
            fontSize: APPResponsive.width(4.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}