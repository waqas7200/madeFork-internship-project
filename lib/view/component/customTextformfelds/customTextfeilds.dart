import 'package:flutter/material.dart';

import '../../utils/costsColors/constColors.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
class CustomTextField extends StatefulWidget {

  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData prefixIcon;

  const CustomTextField({
    super.key,

    required this.hint,
    required this.controller,
    required this.validator,
    required this.prefixIcon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   widget.label,
        //   style: TextStyle(
        //     fontSize: AppResponsive.width(3.8),
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black87,
        //   ),
        // ),
        // const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscure : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: AppResponsive.width(3.8),
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: AppColor.backgroundBlue,
              size: AppResponsive.width(5.5),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade400,
                size: AppResponsive.width(5),
              ),
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
            )
                : null,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(4),
              vertical: AppResponsive.height(2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.width(3)),
              borderSide: BorderSide.none,
            ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(AppResponsive.width(3)),
            //   borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.width(3)),
              borderSide: BorderSide(color: AppColor.backgroundBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.width(3)),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.width(3)),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}