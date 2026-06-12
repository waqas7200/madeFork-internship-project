import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const CustomLoadingWidget({
    Key? key,
    this.size = 40.0,
    this.strokeWidth = 4.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColor.backgroundBlue,
          ),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
